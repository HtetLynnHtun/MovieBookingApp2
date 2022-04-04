//
//  ProfileVO.swift
//  MovieBookingApp2
//
//  Created by kira on 04/04/2022.
//

import Foundation

struct ProfileVO: Codable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let totalExpense: Int
    let profileImage: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case phone
        case totalExpense = "total_expense"
        case profileImage = "profile_image"
    }
}
