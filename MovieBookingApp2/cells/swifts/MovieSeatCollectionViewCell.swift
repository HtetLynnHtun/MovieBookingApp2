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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindData(movieSeatVO: MovieSeatVO) {
        lableMovieSeatTitle.text = movieSeatVO.title
        
        if movieSeatVO.isMovieSeatRowTitle() {
            viewContainerMovieSeat.layer.cornerRadius = 0
            viewContainerMovieSeat.backgroundColor = .white
        } else if movieSeatVO.isMovieSeatTaken() {
            viewContainerMovieSeat.clipsToBounds = true
            viewContainerMovieSeat.layer.cornerRadius = 8
            viewContainerMovieSeat.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            viewContainerMovieSeat.backgroundColor = UIColor(named: "movie_seat_taken_color") ?? .gray
        } else if movieSeatVO.isMovieSeatAvailable() {
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
