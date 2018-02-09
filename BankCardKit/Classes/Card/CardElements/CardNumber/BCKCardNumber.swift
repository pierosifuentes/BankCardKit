//
//  BCKCardNumber.swift
//  iOSBankCardFramework
//
//  Created by Piero on 29/11/17.
//

import Foundation

public struct BCKCardNumber {
    public var value: String
    public var splitPattern: [Int]
    public var startIndex: String.Index {
        let number = self.value.digitsUnformated
        return number.index(number.startIndex, offsetBy: 0)
    }
    public var endIndex: String.Index {
        let number = self.value.digitsUnformated
        let firstOffset = number.count-1
        let minPossibleOffset = 4
        return number.index(number.startIndex, offsetBy: min(firstOffset, minPossibleOffset))
    }
    public var expectedLenght: Int {
        return self.splitPattern.reduce(0, { $0 + $1 })
    }
    public init?(cardDigits: String, splitPattern: [Int] = [4, 4, 4, 4]) {
        guard cardDigits.digits.isEmpty == false else { return nil }
        guard splitPattern.isEmpty == false, let first = splitPattern.sorted().first, first > 0 else { return nil }
        self.value = cardDigits
        self.splitPattern = splitPattern
    }
}

public extension BCKCardNumber {
    public var components: [String]? {
        let result = splitPattern.reduce(0, { x, y in x + y })
        guard value.digits.isEmpty == false && value.count == result  else { return nil }
        guard value.count > 0 && value.count == result else { return [] }
        var index = 0
        var components: [String] = []
        for splitGroup in splitPattern {
            let indexStartOfText = value.index(value.startIndex, offsetBy: index)
            index += splitGroup
            let indexEndOfText = value.index(value.endIndex, offsetBy: index)
            let group = value[indexStartOfText...indexEndOfText]
            components.append(String(group))
        }
        return components
    }
    
    public func component(atIndex index: Int) -> String? {
        guard let guardComponents = self.components, guardComponents.count > 0 && index > 0 && index < guardComponents.count else { return nil }
        return guardComponents[index]
    }
    
    public func cardBrand(forAccount account: BCKAccountType = .credit) -> BCKCardBrand {
        let number = self.value.digitsUnformated
        guard number.count > 0 else { return BCKRawCardBrand.nonspecific }
        for brand in BCKBrandManager.shared.registeredBrands {
            let binDigits = account == .credit ? brand.creditBinDigits:brand.debitBinDigits
            if binDigits.includedOn(cardNumber: String(number[startIndex...endIndex])) {
                return brand
            }
        }
        return BCKRawCardBrand.nonspecific
    }
    
    public func isValid(for cardBrand: BCKCardBrand, account: BCKAccountType = .credit) -> Bool {
        let number = self.value.digitsUnformated
        guard number.count > 0 else { return false }
        let binDigits = account == .credit ? cardBrand.creditBinDigits:cardBrand.debitBinDigits
        return binDigits.includedOn(cardNumber: String(number[startIndex...endIndex]))
    }
}

public extension BCKCardNumber {
    public var isValid: BCKValidationResult {
        let lenghtStatus = self.isValidLenght
        let luhnStatus = self.isValidLuhn
        guard self.value.isNumeric else {
            return .cardNumberUnexpectedFormat
        }
        guard lenghtStatus == .valid else {
            return lenghtStatus
        }
        guard luhnStatus == .valid else {
            return luhnStatus
        }
        return .valid
    }
    
    public var isValidLenght: BCKValidationResult {
        if self.value.count == self.expectedLenght {
            return .valid
        } else if self.value.count < self.expectedLenght {
            return .numberIncomplete
        } else if self.value.count > self.expectedLenght {
            return .numberTooLong
        } else {
            return .numberNotMatchType
        }
    }
    public var isValidLuhn: BCKValidationResult {
        var odd = true
        var sum = 0
        var digits: [String] = []
        for c in self.value {
            digits.append(String(c))
        }
        for c in digits.reversed() {
            guard var digit = Int(c) else { return .luhnTestFailed }
            odd = !odd
            if odd {
                digit = digit * 2
            }
            if digit > 9 {
                digit = digit - 9
            }
            sum += digit
        }
        
        if sum % 10 == 0 {
            return .valid
        } else {
            return .luhnTestFailed
        }
    }
}

public extension String {
    public func cardBrand(accountType: BCKAccountType) -> BCKCardBrand {
        let number = self.digitsUnformated
        guard number.count > 0 else { return BCKRawCardBrand.nonspecific }
        let startIndex = number.index(number.startIndex, offsetBy: 0)
        let endIndex = number.index(number.startIndex, offsetBy: min(number.count-1, 4))
        
        for brand in BCKBrandManager.shared.registeredBrands {
            let binDigits = accountType == .credit ? brand.creditBinDigits:brand.debitBinDigits
            if binDigits.includedOn(cardNumber: String(number[startIndex...endIndex])) {
                return brand
            }
        }
        
        return BCKRawCardBrand.nonspecific
    }
    
    public func accountType() -> BCKAccountType? {
        let number = self.digitsUnformated
        guard number.count > 0 else { return nil }
        
        for brand in BCKBrandManager.shared.registeredBrands {
            if brand.debitBinDigits.includedOn(cardNumber: number) {
                return .debit
            } else if brand.creditBinDigits.includedOn(cardNumber: number) {
                return .credit
            }
        }
        return nil
    }
}

public extension String {
    public var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    public var digitsUnformated: String {
        return self.replacingOccurrences(of: " ", with: "").trimmingCharacters(in: .whitespaces).digits
    }
    public var isNumeric: Bool {
        return self.reduce(true, { (result, c) -> Bool in
            let value = String(c)
            guard let firstChar = value.utf16.first, let first = UnicodeScalar(firstChar) else { return result }
            return result && CharacterSet.decimalDigits.contains(first)
        })
    }
}






