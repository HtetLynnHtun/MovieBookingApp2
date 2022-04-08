//
//  DateHelper.swift
//  MovieBookingApp2
//
//  Created by kira on 06/04/2022.
//

import Foundation

class DateHelper {
    static func next10Days() -> [MyDate] {
        let today = Calendar.current
        var next10Dates = [Date.now]
        
        for i in 1...9 {
            let nextDate = today.date(byAdding: .day, value: i, to: Date.now)!
            next10Dates.append(nextDate)
        }
        
        return next10Dates.map { date -> MyDate in
            let day = today.component(.day, from: date)
            let short = DateFormatter().shortWeekdaySymbols[today.component(.weekday, from: date) - 1]
            let year = today.component(.year, from: date)
            let month = today.component(.month, from: date)
            let complete = "\(year)-\(month)-\(day)"
            return MyDate(weekday: short, day: day, complete: complete)
        }
    }
}

struct MyDate {
    let weekday: String
    let day: Int
    let complete: String
}
