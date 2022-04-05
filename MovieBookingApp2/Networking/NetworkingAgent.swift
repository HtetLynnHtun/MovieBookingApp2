//
//  NetworkingAgent.swift
//  MovieBookingApp2
//
//  Created by kira on 04/04/2022.
//

import Foundation
protocol NetworkingAgent {
    
    // MARK: Authentication endpoints
    func signIn(credentials: UserCredentialsVO, completion: @escaping (MBAResult<ApiResponse<ProfileVO>>) -> Void)
    func loginWithEmail(credentials: UserCredentialsVO, completion: @escaping (MBAResult<ApiResponse<ProfileVO>>) -> Void)
    func loginWithGoogle(token: String, completion: @escaping (MBAResult<ApiResponse<ProfileVO>>) -> Void)
    
    func getProfile(token: String, completion: @escaping (MBAResult<ProfileVO>) -> Void)
}
