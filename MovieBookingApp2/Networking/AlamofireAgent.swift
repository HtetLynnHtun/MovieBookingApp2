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
    
    func signInWithEmail(credentials: UserCredentialsVO, completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        let parameters = credentials.toParameters()
        
        AF.request(MBAEndpoint.signInWithEmail, method: .post, parameters: parameters)
            .responseDecodable(of: ApiResponse<ProfileVO>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    if ((200..<300).contains(apiResponse.code)) {
                        completion(.success(apiResponse.data!))
                    } else {
                        completion(.failure("A user already existed with that phone number."))
                    }
                case .failure(let error):
                    if (isNoConnectionError(error: error)) {
                        completion(.failure("Please connect to the Internet and try again."))
                    }
                }
            }
    }
    
    func loginWithEmail(credentials: UserCredentialsVO, completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        let parameters = credentials.toParameters()
        
        AF.request(MBAEndpoint.loginWithEmail, method: .post, parameters: parameters)
            .responseDecodable(of: ApiResponse<ProfileVO>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    if ((200..<300).contains(apiResponse.code)) {
                        completion(.success(apiResponse.data!))
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
    
}
