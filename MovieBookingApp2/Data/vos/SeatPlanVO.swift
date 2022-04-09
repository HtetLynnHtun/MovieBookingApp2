//
//  SeatPlanVO.swift
//  MovieBookingApp2
//
//  Created by kira on 09/04/2022.
//

import Foundation
import RealmSwift

class SeatPlanVO: Object {
    
    @Persisted(primaryKey: true)
    var id: String
    
    @Persisted
    var seats: List<SeatVO>
}
