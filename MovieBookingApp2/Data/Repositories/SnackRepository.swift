//
//  SnackRepository.swift
//  MovieBookingApp2
//
//  Created by kira on 09/04/2022.
//

import Foundation

protocol SnackRepository {
    func saveSnacks(data: [SnackVO])
    func getSnacks(completion: @escaping ([SnackVO]) -> Void)
}

class SnackRepositoryImpl: BaseRepository, SnackRepository {
    
    static let shared = SnackRepositoryImpl()
    private override init() { }
    
    func saveSnacks(data: [SnackVO]) {
        do {
            try self.realm.write({
                self.realm.add(data, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getSnacks(completion: @escaping ([SnackVO]) -> Void) {
        completion(Array(self.realm.objects(SnackVO.self)))
    }
}
