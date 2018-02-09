//
//  BCKVerificationCode.swift
//  BankCardKit
//
//  Created by Piero on 28/12/17.
//

import Foundation
import Security

public struct BCKVerificationCode {
    
    var value: String
    
    var integerValue: Int? {
        return Int(value)
    }
    
    var isRequired: Bool
    
    public var lenght: Int
    
    init?(code: String, lenght: Int = 4, isRequired: Bool = true) {
        guard code.digits.count == lenght else { return nil }
        self.lenght = lenght
        self.value = code
        self.isRequired = isRequired
    }
}

public extension BCKVerificationCode {
    public var isValid: BCKValidationResult {
        guard isRequired else { return .valid }
        guard self.integerValue != nil else { return .invalidCVC }
        if value.count > lenght {
            return .invalidCVC
        } else if value.count < lenght {
            return .incompleteCVC
        }
        return .valid
    }
}
