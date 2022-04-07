//
//  CinemaRepository.swift
//  MovieBookingApp2
//
//  Created by kira on 07/04/2022.
//

import Foundation

protocol CinemaRepository {
    func saveCinemas(data: [CinemaVO])
    func getCinemas(completion: @escaping ([CinemaVO]) -> Void)
}

class CinemaRepositoryImpl: BaseRepository, CinemaRepository {
    
    static let shared = CinemaRepositoryImpl()
    private override init() {}
    
    func saveCinemas(data: [CinemaVO]) {
        do {
            try self.realm.write({
                self.realm.add(data, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getCinemas(completion: @escaping ([CinemaVO]) -> Void) {
        completion(Array(self.realm.objects(CinemaVO.self)))
    }
    
}
