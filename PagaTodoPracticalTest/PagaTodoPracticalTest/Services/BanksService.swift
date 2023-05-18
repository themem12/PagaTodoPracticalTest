//
//  BanksService.swift
//  PagaTodoPracticalTest
//
//  Created by Guillermo Saavedra Dorantes  on 18/05/23.
//

import Foundation
import Combine

protocol ApiServiceType {
    func getBanksList() -> AnyPublisher<[BankModel], Error>
}

class ApiService: ApiServiceType {
    func getBanksList() -> AnyPublisher<[BankModel], Error> {
        guard let url = URL(string: "https://dev.obtenmas.com/catom/api/challenge/banks") else {
            return Empty().eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .catch { error in
                return Fail(error: error).eraseToAnyPublisher()
            }.map({$0.data})
            .decode(type: [BankModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
