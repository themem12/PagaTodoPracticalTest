//
//  UIImageViewHelpers.swift
//  PagaTodoPracticalTest
//
//  Created by Guillermo Saavedra Dorantes  on 18/05/23.
//

import UIKit

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let imageData = data else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = UIImage(data: imageData)
            }
        }.resume()
    }
}
