//
//  TimeCollectionViewCell.swift
//  MovieBookingApp2
//
//  Created by kira on 16/02/2022.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slotLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    var data: String? {
        didSet {
            if let data = data {
                slotLabel.text = data
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 4
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray.cgColor
    }

    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                containerView.backgroundColor = UIColor(named: "primary_color")
                containerView.layer.borderColor = UIColor(named: "primary_color")?.cgColor
                slotLabel.textColor = .white
            } else {
                containerView.backgroundColor = .clear
                containerView.layer.borderColor = UIColor.systemGray.cgColor
                slotLabel.textColor = .black
            }
        }
    }
}
