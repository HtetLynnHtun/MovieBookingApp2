//
//  PaymentMethodModel.swift
//  MovieBookingApp2
//
//  Created by kira on 12/04/2022.
//

import Foundation

protocol PaymentMethodModel {
    func getPaymentMethods(completion: @escaping (MBAResult<[PaymentMethodVO]>) -> Void)
}

class PaymentMethodModelImpl: PaymentMethodModel {
    
    static let shared = PaymentMethodModelImpl()
    private init() { }
    
    let networkingAgent: NetworkingAgent = AlamofireAgent.shared
    let authModel: AuthModel = AuthModelImpl.shared
    let paymentMethodRepository: PaymentMethodRepository = PaymentMethodRepositoryImpl.shared
    
    func getPaymentMethods(completion: @escaping (MBAResult<[PaymentMethodVO]>) -> Void) {
        networkingAgent.getPaymentMethods(token: authModel.getUserToken()) { result in
            switch result {
            case .success(let data):
                self.paymentMethodRepository.savePaymentMethods(data: data)
            case .failure(let errorMessage):
                print(errorMessage)
            }
            self.paymentMethodRepository.getPaymentMethods { data in
                completion(.success(data))
            }
        }
    }
}
