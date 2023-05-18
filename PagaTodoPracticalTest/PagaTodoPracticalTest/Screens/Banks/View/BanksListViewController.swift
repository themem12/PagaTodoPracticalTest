//
//  ViewController.swift
//  PagaTodoPracticalTest
//
//  Created by Guillermo Saavedra Dorantes  on 17/05/23.
//

import UIKit
import Combine

class BanksListViewController: UIViewController {
    
    @IBOutlet weak var banksTableView: UITableView!
    @IBOutlet weak var isLoadingIndicator: UIActivityIndicatorView!
    
    private let viewModel = BanksListViewModel()
    
    private let input: PassthroughSubject<BanksListViewModel.Input, Never> = .init()
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        initTable()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        input.send(.viewDidAppear)
    }
    
    private func initTable() {
        banksTableView.register(BankTableViewCell.nib, forCellReuseIdentifier: BankTableViewCell.identifier)
        
        banksTableView.delegate = viewModel
        banksTableView.dataSource = viewModel
        
        banksTableView.tableHeaderView?.layoutIfNeeded()
        banksTableView.tableHeaderView = banksTableView.tableHeaderView
        
        banksTableView.separatorColor = .white
        banksTableView.separatorStyle = .singleLine
        banksTableView.allowsSelection = false
    }
    
    private func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
            switch event {
            case .fetchListDidFail(let error):
                debugPrint("error: ", error.localizedDescription)
                
            case .fetchListDidSucceed:
                self?.banksTableView.reloadData()
                
            case .toggleActivity(isLoading: let isLoading):
                self?.isLoadingIndicator.isHidden = !isLoading
            }
        }.store(in: &cancellable)
    }
}
