//
//  DateManger.swift
//  Sportify
//
//  Created by Macos on 16/05/2025.
//

import Foundation

struct DateManger{
    
    static func getCurrentDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: Date())
        return formattedDate
    }
    
    static func getFutureDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let futureDate = Calendar.current.date(byAdding: .day, value: 30, to: Date()) {
            let formattedDate = dateFormatter.string(from: futureDate)
            return formattedDate
        }

        return ""
    }
    
    static func getPastDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let futureDate = Calendar.current.date(byAdding: .day, value: -30, to: Date()) {
            let formattedDate = dateFormatter.string(from: futureDate)
            return formattedDate
        }

        return ""
    }
}
