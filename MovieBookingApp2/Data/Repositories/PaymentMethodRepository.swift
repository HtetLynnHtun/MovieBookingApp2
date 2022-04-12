//
//  PaymentMethodRepository.swift
//  MovieBookingApp2
//
//  Created by kira on 12/04/2022.
//

import Foundation

protocol PaymentMethodRepository {
    func savePaymentMethods(data: [PaymentMethodVO])
    func getPaymentMethods(completion: @escaping ([PaymentMethodVO]) -> Void)
    func updateCards(_ data: [CardVO], completion: @escaping (Bool) -> Void)
}

class PaymentMethodRepositoryImpl: BaseRepository, PaymentMethodRepository {
    
    static let shared = PaymentMethodRepositoryImpl()
    
    private override init() { }
    
    private let profileRepository: ProfileRepository = ProfileRepositoryImpl.shared
    
    func savePaymentMethods(data: [PaymentMethodVO]) {
        do {
            try self.realm.write {
                self.realm.add(data, update: .modified)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getPaymentMethods(completion: @escaping ([PaymentMethodVO]) -> Void) {
        completion(Array(self.realm.objects(PaymentMethodVO.self)))
    }
    
    func updateCards(_ data: [CardVO], completion: @escaping (Bool) -> Void) {
        profileRepository.getProfile { result in
            switch result {
            case .success(let profileVO):
                do {
                    try self.realm.write({
                        profileVO.cards.append(data.last!)
                    })
                    completion(true)
                } catch {
                    print(error.localizedDescription)
                    completion(false)
                }
            case .failure(let errorMessage):
                print(errorMessage)
                completion(false)
            }
        }
    }
}
