//
//  ProfileVO.swift
//  MovieBookingApp2
//
//  Created by kira on 04/04/2022.
//

import Foundation
import RealmSwift

class ProfileVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var name: String
    
    @Persisted
    var email: String
    
    @Persisted
    var phone: String
    
    @Persisted
    var totalExpense: Int
    
    @Persisted
    var profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case phone
        case totalExpense = "total_expense"
        case profileImage = "profile_image"
    }
}
