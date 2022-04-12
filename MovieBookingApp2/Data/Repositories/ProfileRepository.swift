//
//  ProfileRepository.swift
//  MovieBookingApp2
//
//  Created by kira on 05/04/2022.
//

import Foundation

protocol ProfileRepository {
    func saveProfile(_ profile: ProfileVO)
    func getProfile(completion: @escaping (MBAResult<ProfileVO>) -> Void)
}

class ProfileRepositoryImpl: BaseRepository, ProfileRepository {
    
    override private init() { }
    
    static let shared = ProfileRepositoryImpl()
    
    func saveProfile(_ profile: ProfileVO) {
        do {
            try self.realm.write({
                self.realm.add(profile, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getProfile(completion: @escaping (MBAResult<ProfileVO>) -> Void) {
        completion(.success(self.realm.objects(ProfileVO.self).first!))
    }
    
}
