//
//  TimeSlotVO.swift
//  MovieBookingApp2
//
//  Created by kira on 07/04/2022.
//

import Foundation
import RealmSwift

class TimeSlotVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var startTime: String
    
    enum CodingKeys: String, CodingKey {
        case id = "cinema_day_timeslot_id"
        case startTime = "start_time"
    }
}
