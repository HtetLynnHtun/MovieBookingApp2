//
//  ApiResponse.swift
//  MovieBookingApp2
//
//  Created by kira on 04/04/2022.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    let code: Int
    let message: String
    let data: T?
    let token: String?
}
