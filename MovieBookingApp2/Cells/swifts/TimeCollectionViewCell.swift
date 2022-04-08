//
//  TimeCollectionViewCell.swift
//  MovieBookingApp2
//
//  Created by kira on 16/02/2022.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slotLabel: UILabel!

    var data: String? {
        didSet {
            if let data = data {
                slotLabel.text = data
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
