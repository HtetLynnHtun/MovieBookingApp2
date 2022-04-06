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
    case profile
    case nowShowingMovies
    case comingSoonMovies
    case movieDetails(Int)
    
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
        case .profile:
            return "/profile"
        case .nowShowingMovies:
            return "/movies?status=current"
        case .comingSoonMovies:
            return "/movies?status=comingsoon"
        case .movieDetails(let id):
            return "/movies/\(id)"
        }
    }
}
