//
//  CinemaModel.swift
//  MovieBookingApp2
//
//  Created by kira on 07/04/2022.
//

import Foundation

protocol CinemaModel {
    func getCinemas(completion: @escaping (MBAResult<[CinemaVO]>) -> Void)
}

class CinemaModelImpl: CinemaModel {
    
    static let shared = CinemaModelImpl()
    private let networkingAgent: NetworkingAgent = AlamofireAgent.shared
    private let cinemaRepository: CinemaRepository = CinemaRepositoryImpl.shared
    
    private init() { }
    
    func getCinemas(completion: @escaping (MBAResult<[CinemaVO]>) -> Void) {
        networkingAgent.getCinemas { result in
            switch result {
            case .success(let data):
                self.cinemaRepository.saveCinemas(data: data)
            case .failure(let errorMessage):
                print(errorMessage)
            }
            self.cinemaRepository.getCinemas { data in
                completion(.success(data))
            }
        }
    }
}
