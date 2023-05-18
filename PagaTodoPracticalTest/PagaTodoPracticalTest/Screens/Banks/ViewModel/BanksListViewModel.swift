//
//  BanksListViewModel.swift
//  PagaTodoPracticalTest
//
//  Created by Guillermo Saavedra Dorantes  on 18/05/23.
//

import UIKit
import Combine
import CoreData

class BanksListViewModel: NSObject {
    
    enum Input {
        case viewDidAppear
    }
    
    enum Output {
        case fetchListDidFail(error: Error)
        case fetchListDidSucceed
        case toggleActivity(isLoading: Bool)
    }
    
    private let apiService: ApiServiceType
    private let output: PassthroughSubject<Output, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    private let container: NSPersistentContainer
    
    private var banksList = [BankModel]()
    
    init(apiService: ApiServiceType = ApiService()) {
        self.apiService = apiService
        
        container = NSPersistentContainer(name: "PagaTodoPracticalTest")
        container.loadPersistentStores { description, error in
            if let error = error {
                debugPrint("Error cargando CoreData: \(error)")
            }
        }
    }
    
    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .viewDidAppear:
                self?.getBanksFromCoreData()
            }
        }.store(in: &cancellables)
        
        return output.eraseToAnyPublisher()
    }
    
    private func getBanksFromCoreData() {
        let request = NSFetchRequest<BankEntity>(entityName: "BankEntity")
        
        do {
            let banksList = try container.viewContext.fetch(request)
            
            if banksList.isEmpty {
                handleGetApiRequest()
            } else {
                self.banksList = banksList.compactMap({
                    BankModel(description: $0.descriptionText ?? "", age: Int($0.age), url: $0.url ?? "", bankName: $0.name ?? "")
                })
                output.send(.toggleActivity(isLoading: false))
                output.send(.fetchListDidSucceed)
            }
        } catch {
            debugPrint("Error al traer valores: \(error)")
        }
    }
    
    
    private func handleGetApiRequest() {
        output.send(.toggleActivity(isLoading: true))
        apiService.getBanksList().sink { [weak self] completion in
            self?.output.send(.toggleActivity(isLoading: false))
            if case .failure(let error) = completion {
                self?.output.send(.fetchListDidFail(error: error))
            }
        } receiveValue: { [weak self] banksList in
            self?.saveToCoreData(data: banksList)
            self?.banksList = banksList
            self?.output.send(.fetchListDidSucceed)
        }.store(in: &cancellables)
    }
    
    private func saveToCoreData(data: [BankModel]) {
        guard let entity = NSEntityDescription.entity(forEntityName: "BankEntity", in: container.viewContext) else { return }
        
        for bank in data {
            let newBankEntity = NSManagedObject(entity: entity, insertInto: container.viewContext)
            newBankEntity.setValue(bank.bankName, forKey: "name")
            newBankEntity.setValue(bank.age, forKey: "age")
            newBankEntity.setValue(bank.description, forKey: "descriptionText")
            newBankEntity.setValue(bank.url, forKey: "url")
        }
        
        do {
            try container.viewContext.save()
        } catch {
            debugPrint("Error al guardar en CoreData")
        }
    }
}

extension BanksListViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        banksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BankTableViewCell.identifier) as? BankTableViewCell else { return UITableViewCell() }
        let cellInfo = banksList[indexPath.row]
        
        cell.nameLabel.text = "Nombre: \(cellInfo.bankName)"
        cell.ageLabel.text = "Tiempo: \(cellInfo.age)"
        cell.iconImageView.loadFrom(URLAddress: cellInfo.url)
        cell.descriptionLabel.text = cellInfo.description
        
        return cell
    }
}
