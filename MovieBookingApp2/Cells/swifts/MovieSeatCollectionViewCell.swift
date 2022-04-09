//
//  MovieSeatCollectionViewCell.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import UIKit

class MovieSeatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewContainerMovieSeat: UIView!
    @IBOutlet weak var lableMovieSeatTitle: UILabel!
    
    var data: SeatVO? {
        didSet {
            setupView()
        }
    }
    var onTap: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lableMovieSeatTitle.textColor = .clear
    }
    
    override var isSelected: Bool {
        didSet {
            if (isSelected) {
                lableMovieSeatTitle.textColor = .white
                viewContainerMovieSeat.backgroundColor = UIColor(named: "primary_color")
            } else {
                lableMovieSeatTitle.textColor = .clear
                viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_available_color")
            }
        }
    }
    
    private func setupView() {
        if let data = data {
            
            if data.isRowTitle() {
                lableMovieSeatTitle.text = data.symbol
                lableMovieSeatTitle.textColor = .black
                viewContainerMovieSeat.layer.cornerRadius = 0
                viewContainerMovieSeat.backgroundColor = .white
            } else if data.isTaken() {
                viewContainerMovieSeat.clipsToBounds = true
                viewContainerMovieSeat.layer.cornerRadius = 8
                viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_taken_color") ?? .gray
            } else if data.isAvailable() {
                lableMovieSeatTitle.text = data.getSeatNumber()
                viewContainerMovieSeat.clipsToBounds = true
                viewContainerMovieSeat.layer.cornerRadius = 8
                viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_available_color") ?? .lightGray
            } else {
                viewContainerMovieSeat.layer.cornerRadius = 0
                viewContainerMovieSeat.backgroundColor = .white
            }
        }
    }
    
}
