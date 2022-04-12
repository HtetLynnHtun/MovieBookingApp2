//
//  PaymentMethodVO.swift
//  MovieBookingApp2
//
//  Created by kira on 12/04/2022.
//

import Foundation
import RealmSwift

class PaymentMethodVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var name: String
    
    @Persisted
    var desc: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
    }
    
}
