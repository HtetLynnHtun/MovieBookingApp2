//
//  CheckoutVO.swift
//  MovieBookingApp2
//
//  Created by kira on 15/04/2022.
//

import Foundation

struct CheckoutVO: Codable {
    
    var bookingNo: String
    var qrCode: String
    
    enum CodingKeys: String, CodingKey {
        case bookingNo = "booking_no"
        case qrCode = "qr_code"
    }
}
