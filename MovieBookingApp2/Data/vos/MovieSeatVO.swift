//
//  MovieSeatVO.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import Foundation

struct MovieSeatVO {
    var title: String
    var type: String
    
    func isMovieSeatAvailable() -> Bool {
        return type == SEAT_TYPE_AVAILABLE
    }
    
    func isMovieSeatTaken() -> Bool {
        return type == SEAT_TYPE_TAKEN
    }
    
    func isMovieSeatRowTitle() -> Bool {
        return type == SEAT_TYPE_TEXT
    }
}
