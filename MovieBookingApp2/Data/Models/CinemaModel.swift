//
//  CinemaModel.swift
//  MovieBookingApp2
//
//  Created by kira on 07/04/2022.
//

import Foundation

protocol CinemaModel {
    func getCinemas(completion: @escaping (MBAResult<[CinemaVO]>) -> Void)
    func getDayTimeSlots(for date: String, completion: @escaping (MBAResult<[CinemaDayTimeSlotVO]>) -> Void)
    func getSeatPlan(of slotId: Int, for date: String, completion: @escaping (MBAResult<SeatPlanVO>) -> Void)
}

class CinemaModelImpl: CinemaModel {
    
    static let shared = CinemaModelImpl()
    private let authModel: AuthModel = AuthModelImpl.shared
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
    
    func getDayTimeSlots(for date: String, completion: @escaping (MBAResult<[CinemaDayTimeSlotVO]>) -> Void) {
        networkingAgent.getCinemaDayTimeSlots(token: authModel.getUserToken(), for: date) { result in
            switch result {
            case .success(let data):
                self.cinemaRepository.saveDayTimeSlots(for: date, data: data)
            case .failure(let errorMessage):
                print(errorMessage)
            }
            self.cinemaRepository.getDayTimeSlots(for: date) { data in
                completion(.success(data))
            }
        }
    }
    
    func getSeatPlan(of slotId: Int, for date: String, completion: @escaping (MBAResult<SeatPlanVO>) -> Void) {
        networkingAgent.getSeatPlan(of: slotId, for: date, token: authModel.getUserToken()) { result in
            switch result {
            case .success(let data):
                self.cinemaRepository.saveSeatPlan(of: slotId, for: date, data: data)
            case .failure(let errorMessage):
                print(errorMessage)
            }
            
            self.cinemaRepository.getSeatPlan(of: slotId, for: date) { data in
                completion(.success(data))
            }
        }
    }
}
