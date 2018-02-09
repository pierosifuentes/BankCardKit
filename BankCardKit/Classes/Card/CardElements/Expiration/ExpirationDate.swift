//
//  BCKExpirationDate.swift
//  iOSBankCardFramework
//
//  Created by Piero on 8/11/17.
//

import Foundation

/// Expiration date structure, use this for cards
public struct BCKExpirationDate {
    
    /// Gregorian Calendar used to handle dates on the expiration date object
    private let gregorianCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    /// Date value of the expiration date. Its generated on the instance of the Expiration Date Object
    public var date: Date
    
    /// The month of the expiration date.
    public var month: UInt {
        guard let month = self.components().month else { fatalError("Can't get month component from date, review the init values or open a bug on github") }
        return UInt(month)
    }
    
    /// The year of the expiration date.
    public var year: UInt {
        guard let year = self.components().year else { fatalError("Can't get year component from date, review the init values or open a bug on github") }
        return UInt(year)
    }
    
    /// The Date passed to String with the format "MM/YY"
    public var dateText: String {
        return "\(self.month)" + separator + "\(self.year)"
    }
    
    private var separator: String
    
    /// Init method to instance a Expiration Date with the date property, only internal use
    ///
    /// - Parameter date: The date formated from MM/YY String or MM String, YY String separated
    private init(date: Date, separator: String = "/") {
        self.date = date
        self.separator = separator
    }
    
    /// Components method to get the date components (month and year) from the date property
    ///
    /// - Returns: DateComponents structure with [.year, .month] from the date property
    private func components() -> DateComponents {
        return self.gregorianCalendar.dateComponents([.year, .month], from: self.date)
    }
    
    /// Creates a ExpirationDate with the given string. This init method could return nil if the expiration date could not be created from the date string
    ///
    /// - Parameter string: A string with the format MM/YY or MM/YYYY. Make sure that there is only one non-numeric separation character in the entire string
    public init?(string: String) {
        guard string.trimmingCharacters(in: CharacterSet.decimalDigits).count == 1 else { return nil }
        let regex = try! NSRegularExpression(pattern: "^(\\d{1,2})[/|-](\\d{1,4})", options: .caseInsensitive)
        var month: String = ""
        var year: String = ""
        
        guard let match = regex.firstMatch(in: string, options: .reportProgress, range: NSMakeRange(0, string.count)) else { return nil }
        let monthRange = match.range(at: 1)
        if monthRange.length > 0, let range = Range(monthRange, in: string) {
            month = String(string[range])
        } else {
            return nil
        }
        
        let yearRange = match.range(at: 2)
        if yearRange.length > 0, let range = Range(yearRange, in: string) {
            year = String(string[range])
        } else {
            return nil
        }
        self.init(month: month, year: year)
    }
    
    /// Creates a ExpirationDate with the given month and year strings. This init method could return nil if the expiration date could not be created from the month or year strings.
    ///
    /// - Parameter month: The month string (of numeric format MM).
    /// - Parameter year: The year string (of numeric format YY or YYYY).
    public init?(month: String, year: String) {
        guard let monthVal = UInt(month), let yearVal = UInt(year), year.count >= 2 else {
            return nil
        }
        self.init(month: monthVal, year: yearVal)
    }
    
    /// Creates a ExpirationDate with the given month and year strings. This init method could return nil if the expiration date could not be created from the month or year strings.
    ///
    /// - Parameter month: The month UInt (of numeric format MM).
    /// - Parameter year: The year UInt (of numeric format YY or YYYY).
    public init?(month: UInt, year: UInt) {
        let numberPrefix: UInt = 2000
        let minYear: UInt = 2000
        
        let yearValue: UInt = {
            if year < 100 {
                return year + numberPrefix
            }
            return year
        }()
        
        guard (1...12).contains(month) else { return nil }
        guard yearValue >= minYear else { return nil }
        guard let date = BCKExpirationDate.dateWith(month: month, year: yearValue) else { return nil }
        
        self.init(date: date)
    }
    
    /// Parses a month and year number to an Date with time set to one minute before the following month.
    ///
    /// - Parameters:
    ///   - month: The month of the resulting date.
    ///   - year: The year of the resulting date.
    /// - Returns: The date with month and year and time set to one minute before the following month.
    private static func dateWith(month: UInt, year: UInt) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.month = Int(month)
        dateComponents.year = Int(year)
        
        let gregorianCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
        if let components = gregorianCalendar.date(from: dateComponents) {
            let monthRange = gregorianCalendar.range(of: Calendar.Component.day,
                                                     in: Calendar.Component.month,
                                                     for:components)
            
            dateComponents.day = monthRange?.count
            dateComponents.hour = 23
            dateComponents.minute = 59
            
            return gregorianCalendar.date(from: dateComponents)
        }
        
        return nil
    }
}

public extension BCKExpirationDate {
    public var isValid: BCKValidationResult {
        if self.date.timeIntervalSince1970 < Date().timeIntervalSince1970 {
            return .cardExpired
        } else {
            return .valid
        }
    }
}

extension BCKExpirationDate: CustomStringConvertible {
    public var description: String {
        return String(format: "%02i/%04i", arguments: [month, year])
    }
}

extension BCKExpirationDate: Equatable {
    public static func ==(lhs: BCKExpirationDate, rhs: BCKExpirationDate) -> Bool {
        return lhs.date == rhs.date
    }
}

public extension String {
    public var dateUnformated: String {
        return self.replacingOccurrences(of: "/", with: "").digitsUnformated
    }
}
