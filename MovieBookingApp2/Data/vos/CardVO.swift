//
//  CardVO.swift
//  MovieBookingApp2
//
//  Created by kira on 05/04/2022.
//

import Foundation
import RealmSwift

class CardVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var cardHolder: String
    
    @Persisted
    var cardNumber: String
    
    @Persisted
    var expirationDate: String
    
    @Persisted
    var cardType: String
    
    var cvc = 0
    
    func toParameters() -> [String: Any] {
        return [
            "card_holder": cardHolder,
            "card_number": cardNumber,
            "expiration_date": expirationDate,
            "cvc": cvc
        ]
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case cardHolder = "card_holder"
        case cardNumber = "card_number"
        case expirationDate = "expiration_date"
        case cardType = "card_type"
    }
    
}
