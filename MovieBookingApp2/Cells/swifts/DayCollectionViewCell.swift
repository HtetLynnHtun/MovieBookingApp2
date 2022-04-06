//
//  DayCollectionViewCell.swift
//  MovieBookingApp2
//
//  Created by kira on 16/02/2022.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    var date: MyDate? {
        didSet {
            if let date = date {
                weekdayLabel.text = date.weekday
                dayLabel.text = "\(date.day)"
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
