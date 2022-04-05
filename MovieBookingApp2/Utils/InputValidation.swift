//
//  InputValidation.swift
//  MovieBookingApp2
//
//  Created by kira on 05/04/2022.
//

import Foundation

class InputValidation {
    static func isValidEmail(_ email: String) -> Bool {
        let result = email.range(
            of: #"^\S+@\S+\.\S+$"#,
            options: .regularExpression
        )

        return result != nil
    }
}
