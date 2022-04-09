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
        // Initialization code
        lableMovieSeatTitle.textColor = .clear
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
                setupGestureRecognizer()
                
                lableMovieSeatTitle.text = data.getSeatNumber()
                viewContainerMovieSeat.clipsToBounds = true
                viewContainerMovieSeat.layer.cornerRadius = 8
                viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_available_color") ?? .lightGray
            } else {
                viewContainerMovieSeat.layer.cornerRadius = 0
                viewContainerMovieSeat.backgroundColor = .white
            }
            
            if (data.isSelected) {
                lableMovieSeatTitle.textColor = .white
                viewContainerMovieSeat.backgroundColor = UIColor(named: "primary_color")
            }
        }
    }
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCell))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func didTapCell() {
        if let onTap = onTap,
           let data = data {
            onTap(data.seatName)
        }
    }
    
    func bindData(seatVO: SeatVO) {
        
        if seatVO.isRowTitle() {
            lableMovieSeatTitle.text = seatVO.symbol
            lableMovieSeatTitle.textColor = .black
            viewContainerMovieSeat.layer.cornerRadius = 0
            viewContainerMovieSeat.backgroundColor = .white
        } else if seatVO.isTaken() {
            viewContainerMovieSeat.clipsToBounds = true
            viewContainerMovieSeat.layer.cornerRadius = 8
            viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_taken_color") ?? .gray
        } else if seatVO.isAvailable() {
            lableMovieSeatTitle.text = seatVO.getSeatNumber()
            viewContainerMovieSeat.clipsToBounds = true
            viewContainerMovieSeat.layer.cornerRadius = 8
            viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_available_color") ?? .lightGray
        } else {
            viewContainerMovieSeat.layer.cornerRadius = 0
            viewContainerMovieSeat.backgroundColor = .white
        }
        
        //        if movieSeatVO.isMovieSeatTaken() {
        //            viewContainerMovieSeat.clipsToBounds = true
        //            viewContainerMovieSeat.layer.cornerRadius = 8
        //            viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //            viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_taken_color") ?? .gray
        //        } else if movieSeatVO.isMovieSeatAvailable() {
        //            viewContainerMovieSeat.clipsToBounds = true
        //            viewContainerMovieSeat.layer.cornerRadius = 8
        //            viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        //            viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_available_color") ?? .lightGray
        //        }
        
    }
}
