//
//  dateFormatter.swift
//  BankCardKit
//
//  Created by Piero on 10/01/18.
//

import Foundation

open class ExpirationDateFormater {
     static open func formatOnEditing(date: String, separator: String = "/", leadingZero: Bool = true) -> String? {
        guard date.isEmpty == false else { return nil }
        let separator = separator.isEmpty ? "/" : separator
        let expirationDate = date.dateUnformated
        var formattedString = ""
        var index = 0
        var character: Character
        while index < expirationDate.count {
            let charIndex = expirationDate.index(expirationDate.startIndex, offsetBy: index)
            character = expirationDate[charIndex]
            if index == 0 {
                if let charValue = Int(String(character)) {
                    if expirationDate.count == 1 {
                        if charValue > 1 && leadingZero {
                            formattedString.append("0")
                        }
                    }
                }
            }
            if index == 1 {
                if let charValue = Int(String(character)) {
                    let firstIndex = expirationDate.index(expirationDate.startIndex, offsetBy: 0)
                    let firstCharacter = expirationDate[firstIndex]
                    if let firstCharValue = Int(String(firstCharacter)) {
                        if expirationDate.count == 2 && firstCharValue == 1 {
                            if charValue > 2 {
                                return formattedString
                            }
                        }
                    }
                    
                }
            }
            
            if index == 2 {
                formattedString.append(separator)
            }
            formattedString.append(character)
            index += 1
        }
        return formattedString
    }
    
    open static func unformat(date: String) -> String {
        return date.dateUnformated
    }
}
