//
//  PaymentMethodCollectionViewCell.swift
//  MovieBookingApp2
//
//  Created by kira on 21/02/2022.
//

import UIKit

class PaymentMethodCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var data: PaymentMethodVO? {
        didSet {
            if let data = data {
                nameLabel.text = data.name
                descLabel.text = data.desc
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
