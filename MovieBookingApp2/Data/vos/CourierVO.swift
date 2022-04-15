//
//  CourierVO.swift
//  MovieBookingApp2
//
//  Created by kira on 14/04/2022.
//

import Foundation

struct CourierVO: CustomStringConvertible, Codable {
    
    var cinemaDayTimeSlotID = 0
    var row = ""
    var seatNumber = ""
    var bookingDate = ""
    var totalPrice = 0.0
    var movieId = 0
    var cardId = 0
    var cinemaID = 0
    var snacks = [[String: Int]]()
    
    enum CodingKeys: String, CodingKey {
        case cinemaDayTimeSlotID = "cinema_day_timeslot_id"
        case row
        case seatNumber = "seat_number"
        case bookingDate = "booking_date"
        case totalPrice = "total_price"
        case movieId = "movie_id"
        case cardId = "card_id"
        case cinemaID = "cinema_id"
        case snacks = "snacks"
    }
    
    // Just for presentation
    var movieName = ""
    var cinemaName = ""
    var readableDate = ""
    var time = ""
    var ticketCost = 0.0
    var bookingNo = ""
    var qrCode = ""
    
    var description: String {
        return """
        cinema_day_timeslot_id: \(cinemaDayTimeSlotID)
        row: \(row)
        seat_number: \(seatNumber)
        booking_date: \(bookingDate)
        total_price: \(totalPrice)
        movie_id: \(movieId)
        card_id: \(cardId)
        cinema_id: \(cinemaID)
        snacks: \(snacks)
        """
    }
}
