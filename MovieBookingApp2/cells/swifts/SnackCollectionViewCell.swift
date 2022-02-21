//
//  SnackCollectionViewCell.swift
//  MovieBookingApp2
//
//  Created by kira on 21/02/2022.
//

import UIKit

class SnackCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stackViewButtons: UIStackView!
    @IBOutlet weak var viewSnackCount: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBorders()
    }
    
    private func setupBorders() {
        stackViewButtons.layer.borderWidth = 0.5
        viewSnackCount.layer.borderWidth = 0.5
        stackViewButtons.layer.cornerRadius = 8
        stackViewButtons.layer.borderColor = UIColor.init(named: "movie_seat_taken_color")?.cgColor
        viewSnackCount.layer.borderColor = UIColor.init(named: "movie_seat_taken_color")?.cgColor
    }

}
