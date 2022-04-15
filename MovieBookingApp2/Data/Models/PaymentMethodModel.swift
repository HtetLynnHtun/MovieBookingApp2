//
//  PaymentMethodModel.swift
//  MovieBookingApp2
//
//  Created by kira on 12/04/2022.
//

import Foundation

protocol PaymentMethodModel {
    func getPaymentMethods(completion: @escaping (MBAResult<[PaymentMethodVO]>) -> Void)
    func createCard(card: CardVO, completion: @escaping (MBAResult<Bool>) -> Void)
    func checkout(courier: CourierVO, completion: @escaping (MBAResult<CheckoutVO>) -> Void)
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
    
    func createCard(card: CardVO, completion: @escaping (MBAResult<Bool>) -> Void) {
        networkingAgent.createCard(token: authModel.getUserToken(), card: card) { result in
            switch result {
            case .success(let data):
                self.paymentMethodRepository.updateCards(data) { isSuccess in
                    if (isSuccess) {
                        completion(.success(true))
                    } else {
                        completion(.failure("Failed to create card"))
                    }
                }
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
    
    func checkout(courier: CourierVO, completion: @escaping (MBAResult<CheckoutVO>) -> Void) {
        networkingAgent.checkout(token: authModel.getUserToken(), courier: courier) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let errorMessage):
                completion(.failure(errorMessage))
            }
        }
    }
}
