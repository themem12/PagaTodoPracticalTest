//
//  ViewController.swift
//  PagaTodoPracticalTest
//
//  Created by Guillermo Saavedra Dorantes  on 17/05/23.
//

import UIKit
import Combine

class BanksListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

class BanksListViewModel {
    
}

protocol ApiServiceType {
    func getBanksList() -> AnyPublisher<BankModel, Error>
}

class ApiService: ApiServiceType {
    func getBanksList() -> AnyPublisher<BankModel, Error> {
        guard let url = URL(string: "https://dev.obtenmas.com/catom/api/challenge/banks") else {
            return Empty().eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }.map({$0.data})
            .decode(type: BankModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

struct BankModel: Decodable {
    let description: String
    let age: Int
    let url: String
    let bankName: String
}
