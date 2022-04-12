//
//  CardCollectionViewCell.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardTypeLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardHolderLabel: UILabel!
    @IBOutlet weak var expiresDateLabel: UILabel!

    var data: CardVO? {
        didSet {
            if let data = data {
                cardTypeLabel.text = data.cardType
                cardNumberLabel.text = String(data.cardNumber.suffix(4))
                cardHolderLabel.text = data.cardHolder
                expiresDateLabel.text = data.expirationDate
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
