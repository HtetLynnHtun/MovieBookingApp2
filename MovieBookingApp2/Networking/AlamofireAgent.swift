//
//  AlamofireAgent.swift
//  MovieBookingApp2
//
//  Created by kira on 04/04/2022.
//

import Foundation
import Alamofire

struct AlamofireAgent: NetworkingAgent {
    
    static let shared = AlamofireAgent()
    
    private init() { }
    
    func signIn(credentials: UserCredentialsVO, completion: @escaping (MBAResult<ApiResponse<ProfileVO>>) -> Void) {
        let parameters = credentials.toParameters()
        
        AF.request(MBAEndpoint.signIn, method: .post, parameters: parameters)
            .responseDecodable(of: ApiResponse<ProfileVO>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    if (isResponseCodeInSuccessRange(apiResponse.code)) {
                        completion(.success(apiResponse))
                    } else {
                        completion(.failure("A user already existed with that phone number."))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    func loginWithEmail(credentials: UserCredentialsVO, completion: @escaping (MBAResult<ApiResponse<ProfileVO>>) -> Void) {
        let parameters = credentials.toParameters()
        
        AF.request(MBAEndpoint.loginWithEmail, method: .post, parameters: parameters)
            .responseDecodable(of: ApiResponse<ProfileVO>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    if (isResponseCodeInSuccessRange(apiResponse.code)) {
                        completion(.success(apiResponse))
                    } else {
                        completion(.failure(apiResponse.message))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    func loginWithGoogle(token: String, completion: @escaping (MBAResult<ApiResponse<ProfileVO>>) -> Void) {
        let parameters = ["access-token": token]
        
        AF.request(MBAEndpoint.loginWithGoogle, method: .post, parameters: parameters)
            .responseDecodable(of: ApiResponse<ProfileVO>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    if (isResponseCodeInSuccessRange(apiResponse.code)) {
                        completion(.success(apiResponse))
                    } else {
                        completion(.failure(apiResponse.message))
                    }
                case .failure(let error):
                    if (isNoConnectionError(error: error)) {
                        completion(.failure("Please connect to the Internet and try again."))
                    }
                }
            }
    }
    
    func getProfile(token: String, completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]

        AF.request(MBAEndpoint.profile, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ApiResponse<ProfileVO>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    completion(.success(apiResponse.data!))
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    func getNowShowingMovies(completion: @escaping (MBAResult<[MovieVO]>) -> Void) {
        AF.request(MBAEndpoint.nowShowingMovies)
            .responseDecodable(of: ApiResponse<[MovieVO]>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    completion(.success(apiResponse.data!))
                case .failure(let error):
                    print("wtbug: =========================")
                    print(error)
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    func getCommingSoonMovies(completion: @escaping (MBAResult<[MovieVO]>) -> Void) {
        AF.request(MBAEndpoint.comingSoonMovies)
            .responseDecodable(of: ApiResponse<[MovieVO]>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    completion(.success(apiResponse.data!))
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    func getMovieDetails(id: Int, completion: @escaping (MBAResult<MovieVO>) -> Void) {
        AF.request(MBAEndpoint.movieDetails(id))
            .responseDecodable(of: ApiResponse<MovieVO>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    completion(.success(apiResponse.data!))
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    func getCinemas(completion: @escaping (MBAResult<[CinemaVO]>) -> Void) {
        AF.request(MBAEndpoint.cinemas)
            .responseDecodable(of: ApiResponse<[CinemaVO]>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    completion(.success(apiResponse.data!))
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    func getCinemaDayTimeSlots(token: String, for date: String, completion: @escaping (MBAResult<[CinemaDayTimeSlotVO]>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(MBAEndpoint.cinemaDayTimeslots(date), headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ApiResponse<[CinemaDayTimeSlotVO]>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    completion(.success(apiResponse.data!))
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    func getSeatPlan(of slotId: Int, for date: String, token: String, completion: @escaping (MBAResult<[[SeatVO]]>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(MBAEndpoint.seatPlan(slotId, date) , headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ApiResponse<[[SeatVO]]>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    completion(.success(apiResponse.data!))
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    // MARK: Helper methods
    private func isNoConnectionError(error: AFError) -> Bool {
        if let underlyingError = error.underlyingError {
            if let urlError = underlyingError as? URLError {
                switch urlError.code {
                case .notConnectedToInternet:
                    return true
                default:
                    return false
                }
            }
        }
        return false
    }
    
    private func isResponseCodeInSuccessRange(_ code: Int) -> Bool{
        return (200..<300).contains(code)
    }
    
    private func handleError(_ error: AFError) -> String {
        if (isNoConnectionError(error: error)) {
            return "Please connect to the Internet and try again."
        } else {
            return error.localizedDescription
        }
    }
    
}
