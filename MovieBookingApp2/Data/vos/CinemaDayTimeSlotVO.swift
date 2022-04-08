//
//  CinemaDayTimeSlotVO.swift
//  MovieBookingApp2
//
//  Created by kira on 07/04/2022.
//

import Foundation
import RealmSwift

class CinemaDayTimeSlotVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: String
    
    @Persisted
    var cinemaId: Int
    
    @Persisted
    var cinemaName: String
    
    @Persisted
    var timeslots: List<TimeSlotVO>
    
    @Persisted
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case cinemaId = "cinema_id"
        case cinemaName = "cinema"
        case timeslots
    }
    
}
