//
//  MBAResult.swift
//  MovieBookingApp2
//
//  Created by kira on 04/04/2022.
//

import Foundation

enum MBAResult<T> {
    case success(T)
    case failure(String)
}
