//
//  SnackVO.swift
//  MovieBookingApp2
//
//  Created by kira on 09/04/2022.
//

import Foundation
import RealmSwift

class SnackVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var name: String
    
    @Persisted
    var desc: String
    
    @Persisted
    var price: Double
    
    @Persisted
    var image: String
    
    var count = 0
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case price
        case image
    }
    
}
