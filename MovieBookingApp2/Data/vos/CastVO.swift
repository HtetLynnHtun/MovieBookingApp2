//
//  CastVO.swift
//  MovieBookingApp2
//
//  Created by kira on 06/04/2022.
//

import Foundation
import RealmSwift

class CastVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case profilePath = "profile_path"
    }
}
