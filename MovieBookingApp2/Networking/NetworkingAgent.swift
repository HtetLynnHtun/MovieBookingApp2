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
    
    func getNowShowingMovies(completion: @escaping (MBAResult<[MovieVO]>) -> Void)
    func getCommingSoonMovies(completion: @escaping (MBAResult<[MovieVO]>) -> Void)
    func getMovieDetails(id: Int, completion: @escaping (MBAResult<MovieVO>) -> Void)
    
    func getCinemas(completion: @escaping (MBAResult<[CinemaVO]>) -> Void)
    func getCinemaDayTimeSlots(token: String, for date: String, completion: @escaping (MBAResult<[CinemaDayTimeSlotVO]>) -> Void)
    func getSeatPlan(of slotId: Int, for date: String, token: String, completion: @escaping (MBAResult<[[SeatVO]]>) -> Void)
    
    func getSnacks(token: String, completion: @escaping (MBAResult<[SnackVO]>) -> Void)
    func getPaymentMethods(token: String, completion: @escaping (MBAResult<[PaymentMethodVO]>) -> Void)
}
