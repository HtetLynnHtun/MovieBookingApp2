//
//  UserCredentialsVO.swift
//  MovieBookingApp2
//
//  Created by kira on 04/04/2022.
//

import Foundation

struct UserCredentialsVO {
    let email: String
    let password: String
    let name: String
    let phone: String
    let googleAccessToken: String
    let facebookAccessToken: String
    
    /// Cast to form-url-encoded parameters
    func toParameters() -> [String: String] {
        return [
            "email": email,
            "password": password,
            "name": name,
            "phone": phone,
            "google-access-token": googleAccessToken,
            "facebook-access-token": facebookAccessToken
        ]
    }
}
