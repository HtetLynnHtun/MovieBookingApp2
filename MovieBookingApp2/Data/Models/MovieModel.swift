//
//  MovieModel.swift
//  MovieBookingApp2
//
//  Created by kira on 05/04/2022.
//

import Foundation

protocol MovieModel {
    func getNowShowingMovies(completion: @escaping (MBAResult<[MovieVO]>) -> Void)
    func getCommingSoonMovies(completion: @escaping (MBAResult<[MovieVO]>) -> Void)
}

class MovieModelImpl: MovieModel {
    
    private init() { }
    
    static let shared = MovieModelImpl()
    private let networkingAgent: NetworkingAgent = AlamofireAgent.shared
    private let movieRepository: MovieRepository = MovieRepositoryImpl.shared
    
    func getNowShowingMovies(completion: @escaping (MBAResult<[MovieVO]>) -> Void) {
        networkingAgent.getNowShowingMovies { result in
            switch result {
            case .success(let data):
                self.movieRepository.saveNowShowingMovies(data: data)
                
            case .failure(let errorMessage):
                print(errorMessage)
            }
            self.movieRepository.getNowShowingMovies { data in
                completion(.success(data))
            }
        }
    }
    
    func getCommingSoonMovies(completion: @escaping (MBAResult<[MovieVO]>) -> Void) {
        networkingAgent.getCommingSoonMovies { result in
            switch result {
            case .success(let data):
                self.movieRepository.saveCommingSoonMovies(data: data)
                
            case .failure(let errorMessage):
                print(errorMessage)
            }
            self.movieRepository.getCommingSoonMovies { data in
                completion(.success(data))
            }
        }
    }
}
