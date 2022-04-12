//
//  SnackModel.swift
//  MovieBookingApp2
//
//  Created by kira on 09/04/2022.
//

import Foundation

protocol SnackModel {
    func getSnacks(completion: @escaping (MBAResult<[SnackVO]>) -> Void)
}

class SnackModelImpl: SnackModel {
    
    static let shared = SnackModelImpl()
    private init() { }
    
    let networkingAgent: NetworkingAgent = AlamofireAgent.shared
    let authModel: AuthModel = AuthModelImpl.shared
    let snackRepository: SnackRepository = SnackRepositoryImpl.shared
    
    func getSnacks(completion: @escaping (MBAResult<[SnackVO]>) -> Void) {
        networkingAgent.getSnacks(token: authModel.getUserToken()) { result in
            switch result {
            case .success(let data):
                self.snackRepository.saveSnacks(data: data)
            case .failure(let errorMessage):
                print(errorMessage)
            }
            self.snackRepository.getSnacks { data in
                completion(.success(data))
            }
        }
    }
}
