//
//  BCKCardBrand.swift
//  iOSBankCardFramework
//
//  Created by Piero on 10/11/17.
//

import Foundation

/// CardBrand is a protocol to define diferents bank cards.
public protocol BCKCardBrand {
    
    /// The card type name (e.g.: Visa, MasterCard, ...)
    var name: String { get }
    
    /// A set of numbers (called BINS) which, let us with the first digits of the card number determine the card brand
    var creditBinDigits: Set<Int> { get }
    
    /// A set of numbers (called BINS) which, let us with the first digits of the card number determine the card brand
    var debitBinDigits: Set<Int> { get }
    
    /// A set of numbers that represents the expected lenght for an especific card brand
    var cardNumberMinLenght: Int { get }
    
    /// A set of numbers that represents the expected lenght for an especific card brand with the card number formatted, Ex: 4444 4123
    var cardNumberFormattedMinLenght: Int { get }
    
    /// The number of digits expected for the Card Validation Code.
    var CVCMinLength: Int { get }
    
    /// The split pattern used to format the card number when typing it into the text field. Defaults is [4,4,4,4]
    var splitPattern: [Int] { get }
    
    /// The split pattern used to format the card number when typing it into the text field. Defaults is [4,4,4,4]
    var logo: UIImage? { get }
}

extension Set where Element == Int {
    func includedOn(cardNumber: String) -> Bool {
        for bin in self {
            let binString = String(bin)
            if cardNumber.prefix(binString.count).contains(binString) { return true }
        }
        return false
    }
}

fileprivate extension String {
    func prefix(_ maxLength: Int) -> String {
        return String(self.prefix(maxLength))
    }
}
