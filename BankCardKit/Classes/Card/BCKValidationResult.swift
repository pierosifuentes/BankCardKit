//
//  BCKValidationResult.swift
//  iOSBankCardFramework
//
//  Created by Piero on 8/11/17.
//

import Foundation

/// Card Validation Result Enum for rules validation
///
public enum BCKValidationResult {
    case valid
    
    /**
     Card number does not match the specified type or is too long.
     */
    case numberNotMatchType
    
    /**
     Card number does match the specified type but is too short.
     - note: This result will be returned for an incompleted card number.
     */
    case numberIncomplete
    
    /**
     Invalid Card Verificaiton Code.
     */
    case invalidCVC
    
    /**
     The Card Verification Code is too short.
     */
    case incompleteCVC
    
    /**
     The card has already expired.
     */
    case cardExpired
    
    /**
     Card number does not match the specified type or is too long.
     */
    case cardNumberUnexpectedFormat
    
    /**
     The Luhn test failed for the credit card number.
     - note: This result might be returned for an incompleted card number.
     */
    case luhnTestFailed
    
    /// Indicates that the type of card could not be inferred.
    case unknownType
    
    /// Indicates that the expiry is invalid
    case invalidExpiry
    
    /// Indicates that the card number is too long.
     case numberTooLong
}
