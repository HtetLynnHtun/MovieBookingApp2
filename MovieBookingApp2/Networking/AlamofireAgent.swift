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
                    completion(.failure(handleError(error)))
                }
            }
    }
    
    func logout(token: String, completion: @escaping (MBAResult<ApiResponse<Bool>>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(MBAEndpoint.logout, method: .post, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ApiResponse<Bool>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    if (isResponseCodeInSuccessRange(apiResponse.code)) {
                        print("wtbug: logout: succes code in range")
                        completion(.success(apiResponse))
                    } else {
                        completion(.failure(apiResponse.message))
                    }
                case .failure(let error):
                    completion(.failure(handleError(error)))
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
    
    func getNowShowingMovies(completion: @escaping (MBAResult<[FilmVO]>) -> Void) {
        AF.request(MBAEndpoint.nowShowingMovies)
            .responseDecodable(of: ApiResponse<[FilmVO]>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    completion(.success(apiResponse.data!))
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    func getCommingSoonMovies(completion: @escaping (MBAResult<[FilmVO]>) -> Void) {
        AF.request(MBAEndpoint.comingSoonMovies)
            .responseDecodable(of: ApiResponse<[FilmVO]>.self) { response in
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
    
    func getSnacks(token: String, completion: @escaping (MBAResult<[SnackVO]>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(MBAEndpoint.snackList, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ApiResponse<[SnackVO]>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    completion(.success(apiResponse.data!))
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    func getPaymentMethods(token: String, completion: @escaping (MBAResult<[PaymentMethodVO]>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(MBAEndpoint.paymentMethods, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ApiResponse<[PaymentMethodVO]>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    completion(.success(apiResponse.data!))
                case .failure(let error):
                    completion(.failure(error.localizedDescription))
                }
            }
    }
    
    func createCard(token: String, card: CardVO, completion: @escaping (MBAResult<[CardVO]>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        let parameters = card.toParameters()
        
        AF.request(MBAEndpoint.createCard,
                   method: .post,
                   parameters: parameters,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ApiResponse<[CardVO]>.self) { response in
            switch response.result {
            case .success(let apiResponse):
                completion(.success(apiResponse.data!))
            case .failure(let error):
                completion(.failure(handleError(error)))
            }
        }
    }
    
    func checkout(token: String, courier: CourierVO, completion: @escaping (MBAResult<CheckoutVO>) -> Void) {
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(MBAEndpoint.checkout,
                   method: .post,
                   parameters: courier,
                   encoder: .json,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: ApiResponse<CheckoutVO>.self) { response in
            switch response.result {
            case .success(let apiResponse):
                completion(.success(apiResponse.data!))
            case .failure(let error):
                completion(.failure(handleError(error)))
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
