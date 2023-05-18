//
//  BankTableViewCell.swift
//  PagaTodoPracticalTest
//
//  Created by Guillermo Saavedra Dorantes  on 18/05/23.
//

import UIKit

class BankTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    public static let identifier = String(describing: BankTableViewCell.self)
    public static let nib = UINib(nibName: identifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        ageLabel.text = nil
        iconImageView.image = nil
        descriptionLabel.text = nil
    }
    
}
