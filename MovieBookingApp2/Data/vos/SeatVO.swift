//
//  MovieSeatVO.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import Foundation
import RealmSwift

class SeatVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: UUID
    
    @Persisted
    var seatId: Int
    
    @Persisted
    var type: String
    
    @Persisted
    var seatName: String
    
    @Persisted
    var symbol: String
    
    @Persisted
    var price: Double
    
    var isSelected = false
    
    enum CodingKeys: String, CodingKey {
        case seatId = "id"
        case type
        case seatName = "seat_name"
        case symbol
        case price
    }
    
    func isAvailable() -> Bool {
        return type == SEAT_TYPE_AVAILABLE
    }
    
    func isTaken() -> Bool {
        return type == SEAT_TYPE_TAKEN
    }
    
    func isRowTitle() -> Bool {
        return type == SEAT_TYPE_TEXT
    }
    
    func getSeatNumber() -> String {
        return String(seatName.dropFirst(2))
    }
}
