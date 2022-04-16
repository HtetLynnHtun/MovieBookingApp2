//
//  MBAEndpoint.swift
//  MovieBookingApp2
//
//  Created by kira on 04/04/2022.
//

import Foundation
import Alamofire

enum MBAEndpoint: URLConvertible {
    
    case signIn
    case loginWithEmail
    case loginWithGoogle
    case logout
    case profile
    case nowShowingMovies
    case comingSoonMovies
    case movieDetails(Int)
    case cinemas
    case cinemaDayTimeslots(String)
    case seatPlan(Int, String)
    case snackList
    case paymentMethods
    case createCard
    case checkout
    
    func asURL() throws -> URL {
        url
    }

    private var url: URL {
        let urlComponents = URLComponents(string: baseUrl.appending(apiPath))
        return urlComponents!.url!
    }
    
    private var baseUrl: String {
        return AppConstants.baseUrl
    }
    
    private var apiPath: String {
        switch self {
        case .signIn:
            return "/register"
        case .loginWithEmail:
            return "/email-login"
        case .loginWithGoogle:
            return "/google-login"
        case .logout:
            return "/logout"
        case .profile:
            return "/profile"
        case .nowShowingMovies:
            return "/movies?status=current"
        case .comingSoonMovies:
            return "/movies?status=comingsoon"
        case .movieDetails(let id):
            return "/movies/\(id)"
        case .cinemas:
            return "/cinemas"
        case .cinemaDayTimeslots(let date):
            return "/cinema-day-timeslots?date=\(date)"
        case .seatPlan(let slotID, let date):
            return "/seat-plan?cinema_day_timeslot_id=\(slotID)&booking_date=\(date)"
        case .snackList:
            return "/snacks"
        case .paymentMethods:
            return "/payment-methods"
        case .createCard:
            return "/card"
        case .checkout:
            return "/checkout"
        }
    }
}
