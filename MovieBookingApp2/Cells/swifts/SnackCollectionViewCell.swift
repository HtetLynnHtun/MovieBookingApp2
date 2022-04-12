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
    @IBOutlet weak var snackNameLabel: UILabel!
    @IBOutlet weak var snackDescriptionLabel: UILabel!
    @IBOutlet weak var snackPriceLabel: UILabel!
    @IBOutlet weak var snackCountLabel: UILabel!
    
    var data: SnackVO? {
        didSet {
            if let data = data {
                snackNameLabel.text = data.name
                snackDescriptionLabel.text = data.desc
                snackPriceLabel.text = "\(data.price)$"
            }
        }
    }
    
    var updateSubTotal: (() -> Void)!
    
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
    
    @IBAction func onTapPlus(_ sender: UIButton) {
        data?.count += 1
        updateCounter()
        updateSubTotal()
    }
    
    @IBAction func onTapMinus(_ sender: UIButton) {
        if
            let data = data,
            data.count > 0 {
            data.count -= 1
        }
        updateCounter()
        updateSubTotal()
    }
    
    private func updateCounter() {
        snackCountLabel.text = "\(data?.count ?? 0)"
    }

}
