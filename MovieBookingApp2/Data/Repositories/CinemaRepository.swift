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
    func saveDayTimeSlots(for date: String, data: [CinemaDayTimeSlotVO])
    func getDayTimeSlots(for date: String, completion: @escaping ([CinemaDayTimeSlotVO]) -> Void)
    func saveSeatPlan(of slotId: Int, for date: String, data: [[SeatVO]])
    func getSeatPlan(of slotId: Int, for date: String, completion: @escaping (SeatPlanVO) -> Void)
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
    
    func saveDayTimeSlots(for date: String, data: [CinemaDayTimeSlotVO]) {
        let objects = data.map { vo -> CinemaDayTimeSlotVO in
            vo.date = date
            vo.id = "\(vo.date)-\(vo.cinemaId)"
            return vo
        }
        do {
            try self.realm.write({
                self.realm.add(objects, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getDayTimeSlots(for date: String, completion: @escaping ([CinemaDayTimeSlotVO]) -> Void) {
        let data: [CinemaDayTimeSlotVO] = self.realm.objects(CinemaDayTimeSlotVO.self)
            .filter { $0.date == date }
        completion(data)
    }
    
    func saveSeatPlan(of slotId: Int, for date: String, data: [[SeatVO]]) {
        let seats: [SeatVO] = Array(data.joined())
        let seatPlan = SeatPlanVO()
        
        do {
            try self.realm.write({
                seatPlan.id = "\(slotId)/\(date)"
                // remove existing seatVO in realm (need cascading delete)
                self.realm.delete(seatPlan.seats)
                seatPlan.seats.append(objectsIn: seats)
                self.realm.add(seatPlan, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getSeatPlan(of slotId: Int, for date: String, completion: @escaping (SeatPlanVO) -> Void) {
        let id = "\(slotId)/\(date)"
        completion(self.realm.object(ofType: SeatPlanVO.self, forPrimaryKey: id)!)
    }
}
