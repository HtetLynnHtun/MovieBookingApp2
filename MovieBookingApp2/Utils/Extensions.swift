//
//  Extensions.swift
//  MovieBookingApp2
//
//  Created by kira on 05/04/2022.
//

import Foundation

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
