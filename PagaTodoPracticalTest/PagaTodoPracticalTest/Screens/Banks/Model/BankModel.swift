//
//  BankModel.swift
//  PagaTodoPracticalTest
//
//  Created by Guillermo Saavedra Dorantes  on 18/05/23.
//

import Foundation

struct BankModel: Decodable {
    let description: String
    let age: Int
    let url: String
    let bankName: String
}
