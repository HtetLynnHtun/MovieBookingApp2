//
//  NetworkingAgent.swift
//  MovieBookingApp2
//
//  Created by kira on 04/04/2022.
//

import Foundation
protocol NetworkingAgent {
    
    // MARK: Authentication endpoints
    func signInWithEmail(credentials: UserCredentialsVO, completion: @escaping (MBAResult<ProfileVO>) -> Void)
    func loginWithEmail(credentials: UserCredentialsVO, completion: @escaping (MBAResult<ProfileVO>) -> Void)
}
