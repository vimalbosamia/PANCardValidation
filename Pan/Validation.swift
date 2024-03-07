//
//  Validation.swift
//  Pan
//
//  Created by Vimal Bosamiya on 07/03/24.
//

import Foundation

class Validation {
    static func validatePAN(_ pan: String) -> Bool {
        let panRegex = "[A-Z]{5}[0-9]{4}[A-Z]"
        return NSPredicate(format: "SELF MATCHES %@", panRegex).evaluate(with: pan)
    }
    
    static func validateDate(day: String, month: String, year: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard day.count == 2, month.count == 2, let dayInt = Int(day), let monthInt = Int(month), let yearInt = Int(year) else { return false }
        
        guard monthInt >= 1, monthInt <= 12 else { return false }
        
        switch monthInt {
        case 1, 3, 5, 7, 8, 10, 12:
            guard dayInt >= 1, dayInt <= 31 else { return false }
        case 4, 6, 9, 11:
            guard dayInt >= 1, dayInt <= 30 else { return false }
        case 2:
            let isLeapYear = yearInt % 4 == 0 && (yearInt % 100 != 0 || yearInt % 400 == 0)
            let maxDay = isLeapYear ? 29 : 28
            guard dayInt >= 1, dayInt <= maxDay else { return false }
        default:
            return false
        }
        
        let dateString = "\(day)/\(month)/\(year)"
        guard let birthDate = dateFormatter.date(from: dateString) else { return false }
        
        let calendar = Calendar.current
    
        guard let earliestDate = dateFormatter.date(from: "01/01/1940") else { return false }
        
        if let pastDate = calendar.date(byAdding: .year, value: -18, to: Date()),
           birthDate <= pastDate,
           birthDate >= earliestDate,
           birthDate <= Date() {
            return true
        }
        
        return false
    }


}
