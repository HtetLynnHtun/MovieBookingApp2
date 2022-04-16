//
//  AuthModel.swift
//  MovieBookingApp2
//
//  Created by kira on 05/04/2022.
//

import Foundation

protocol AuthModel {
    func isUserAlreadyLoggedIn() -> Bool
    func saveUserToken(_ token: String)
    func deleteUserToken()
    func getUserToken() -> String
    func signIn(credentials: UserCredentialsVO, completion: @escaping (MBAResult<ProfileVO>) -> Void)
    func loginWithEmail(credentials: UserCredentialsVO, completion: @escaping (MBAResult<ProfileVO>) -> Void)
    func loginWithGoogle(token: String, completion: @escaping (MBAResult<ProfileVO>) -> Void)
    func logout(completion: @escaping (MBAResult<Bool>) -> Void)
    func getProfile(completion: @escaping (MBAResult<ProfileVO>) -> Void)
}

class AuthModelImpl: AuthModel {
    
    private init() { }
    
    static let shared = AuthModelImpl()
    let defaults = UserDefaults.standard
    let networkingAgent: NetworkingAgent = AlamofireAgent.shared
    let profileRepository: ProfileRepository = ProfileRepositoryImpl.shared
    
    func isUserAlreadyLoggedIn() -> Bool {
        if let _ = defaults.string(forKey: AppConstants.tokenKey) {
            return true
        } else {
            return false
        }
    }
    
    func saveUserToken(_ token: String) {
        defaults.set(token, forKey: AppConstants.tokenKey)
    }
    
    func deleteUserToken() {
        defaults.removeObject(forKey: AppConstants.tokenKey)
    }
    
    func getUserToken() -> String {
        return defaults.string(forKey: AppConstants.tokenKey)!
    }
    
    func signIn(credentials: UserCredentialsVO, completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        networkingAgent.signIn(credentials: credentials) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let apiResponse):
                let profile = apiResponse.data!
                
                self.profileRepository.saveProfile(profile)
                self.saveUserToken(apiResponse.token!)
                completion(.success(profile))
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
    func loginWithEmail(credentials: UserCredentialsVO, completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        networkingAgent.loginWithEmail(credentials: credentials) { result in
            switch result {
            case .success(let apiResponse):
                let profile = apiResponse.data!
                
                self.profileRepository.saveProfile(profile)
                self.saveUserToken(apiResponse.token!)
                completion(.success(profile))
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
    func loginWithGoogle(token: String, completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        networkingAgent.loginWithGoogle(token: token) { result in
            switch result {
            case .success(let apiResponse):
                let profile = apiResponse.data!
                
                self.profileRepository.saveProfile(profile)
                self.saveUserToken(apiResponse.token!)
                completion(.success(profile))
                
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
    func logout(completion: @escaping (MBAResult<Bool>) -> Void) {
        networkingAgent.logout(token: getUserToken()) { result in
            switch result {
            case .success(_):
                self.deleteUserToken()
                completion(.success(true))
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
    func getProfile(completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        networkingAgent.getProfile(token: getUserToken()) { result in
            switch result {
            case .success(let profileVO):
                self.profileRepository.saveProfile(profileVO)
            case .failure(let errorMessage):
                print(errorMessage)
            }
        }
        self.profileRepository.getProfile { result in
            completion(result)
        }
    }
}
