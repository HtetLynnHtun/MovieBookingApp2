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
}

class PaymentMethodRepositoryImpl: BaseRepository, PaymentMethodRepository {
    
    static let shared = PaymentMethodRepositoryImpl()
    
    private override init() { }
    
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
}
