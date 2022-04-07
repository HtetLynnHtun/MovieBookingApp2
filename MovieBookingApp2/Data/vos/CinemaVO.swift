//
//  CinemaVO.swift
//  MovieBookingApp2
//
//  Created by kira on 07/04/2022.
//

import Foundation
import RealmSwift

class CinemaVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var name: String
    
    @Persisted
    var phone: String
    
    @Persisted
    var email: String
    
    @Persisted
    var address: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case phone
        case email
        case address
    }
}
