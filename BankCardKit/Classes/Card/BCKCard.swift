//
//  BCKCard.swift
//  iOSBankCardFramework
//
//  Created by Piero on 8/11/17.
//

import Foundation

///  A card protocol that represents a physical bank card with all its associated attributes.
public protocol BCKCard {
    
    /// It is the n-digit (usually 16-digit) number that is shown on the user's card and is linked to your account with the card issuer.
    var cardNumber: BCKCardNumber { get }
    
    /// The security code on the back of the card, usually CVV. Creates an additional hurdle for hackers who may have stolen your card number from merchant systems or with the help of a skimmer. Default is nil
    var CVC: BCKVerificationCode? { get }
    
    /// The time when you’ll need to replace your card. A custom struct with the format MM/YY
    var expirationDate: BCKExpirationDate { get }
    
    /// The account type of your credit card. It could would be .credit, .debit or .unespecific. Default is unespecific
    var account: BCKAccountType { get }
    
    /// The name of the person authorized to use the card.
    var cardholderName: String? { set get }
    
    /// The brand of payment network the card have detected on the init of the card base on the card number. Default is unespecific
    var cardBrand: BCKCardBrand { get }
    
    /// Your card issuer/bank name, default is nil
    var bankName: String? { set get }
    
    /// Your card issuer/bank logo, default is nil
    var bankLogo: UIImage? { set get }
    
    /// Your card background design image, default is nil
    var cardDesign: UIImage? { set get }
    
    /// User info
    var userInfo: [AnyHashable : Any]? { set get }
    
    /// Init method for a card
    ///
    /// - Parameters:
    ///   - cardNumber: It is the 16-digit number linked to your account with the card issuer. If you use American Express, the card number is only 15 digits and if it is Diners, it will be 14 digits.
    ///   - CVC: The security code on the back of the card, usually CVV. Creates an additional hurdle for hackers who may have stolen your card number from merchant systems or with the help of a skimmer.
    ///   - expirationDate: The time when you’ll need to replace your card. A custom struct with the format MM/YY
    ///   - cardholderName: The name of the person authorized to use the card.
    ///   - cardBrand: The brand of payment network the card have detected on the init of the card base on the card number. Default is unespecific
    ///   - bankName: Your card issuer/bank name, default is nil
    ///   - bankLogo: Your card issuer/bank logo, default is nil
    ///   - cardDesign: Your card background design image, default is nil
    init?(cardNumber: BCKCardNumber, CVC: BCKVerificationCode?, expirationDate: BCKExpirationDate, account: BCKAccountType, cardholderName: String?, cardBrand: BCKCardBrand?, bankName: String?, bankLogo: UIImage?, cardDesign: UIImage?, userInfo: [AnyHashable : Any]?)
    
    /// Init method for a card
    ///
    /// - Parameters:
    ///   - cardNumber: It is the 16-digit number linked to your account with the card issuer. If you use American Express, the card number is only 15 digits and if it is Diners, it will be 14 digits.
    ///   - CVC: The security code on the back of the card, usually CVV. Creates an additional hurdle for hackers who may have stolen your card number from merchant systems or with the help of a skimmer.
    ///   - expirationDate: The time when you’ll need to replace your card. A custom struct with the format MM/YY
    ///   - cardholderName: The name of the person authorized to use the card.
    ///   - cardBrand: The brand of payment network the card have detected on the init of the card base on the card number. Default is unespecific
    ///   - bankName: Your card issuer/bank name, default is nil
    ///   - bankLogo: Your card issuer/bank logo, default is nil
    ///   - cardDesign: Your card background design image, default is nil
    init?(cardNumber: String, CVC: String?, expirationDate: String, account: BCKAccountType, cardholderName: String?, cardBrand: BCKCardBrand?, bankName: String?, bankLogo: UIImage?, cardDesign: UIImage?, userInfo: [AnyHashable : Any]?)
    
    /// Factory method to create a card
    ///
    /// - Parameters:
    ///   - cardNumber: It is the 16-digit number linked to your account with the card issuer. If you use American Express, the card number is only 15 digits and if it is Diners, it will be 14 digits.
    ///   - CVC: security code on the back of the card, usually CVV. Creates an additional hurdle for hackers who may have stolen your card number from merchant systems or with the help of a skimmer.
    ///   - expirationDate: The time when you’ll need to replace your card. A custom struct with the format MM/YY
    ///   - cardholderName: The name of the person authorized to use the card.
    ///   - cardBrand: The brand of payment network the card have detected on the init of the card base on the card number. Default is unespecific
    ///   - bankName: Your card issuer/bank name, default is nil
    ///   - bankLogo: Your card issuer/bank logo, default is nil
    ///   - cardDesign: Your card background design image, default is nil
    static func create(cardNumber: BCKCardNumber, CVC: BCKVerificationCode?, expirationDate: BCKExpirationDate, account: BCKAccountType, cardholderName: String?, cardBrand: BCKCardBrand?, bankName: String?, bankLogo: UIImage?, cardDesign: UIImage?, userInfo: [AnyHashable : Any]?) -> BCKCard?
    
    /// Factory method to create a card
    ///
    /// - Parameters:
    ///   - cardNumber: It is the 16-digit number linked to your account with the card issuer. If you use American Express, the card number is only 15 digits and if it is Diners, it will be 14 digits.
    ///   - CVC: security code on the back of the card, usually CVV. Creates an additional hurdle for hackers who may have stolen your card number from merchant systems or with the help of a skimmer.
    ///   - expirationDate: The time when you’ll need to replace your card. A custom struct with the format MM/YY
    ///   - cardholderName: The name of the person authorized to use the card.
    ///   - cardBrand: The brand of payment network the card have detected on the init of the card base on the card number. Default is unespecific
    ///   - bankName: Your card issuer/bank name, default is nil
    ///   - bankLogo: Your card issuer/bank logo, default is nil
    ///   - cardDesign: Your card background design image, default is nil
    static func create(cardNumber: String, CVC: String?, expirationDate: String, account: BCKAccountType, cardholderName: String?, cardBrand: BCKCardBrand?, bankName: String?, bankLogo: UIImage?, cardDesign: UIImage?, userInfo: [AnyHashable : Any]?) -> BCKCard?
    
}

extension BCKCard {
    var CVC: BCKVerificationCode? { return nil }
    var account: BCKAccountType { return .credit }
    var cardholderName: String? { return nil }
    var cardBrand: BCKCardBrand { return BCKRawCardBrand.nonspecific }
    var bankName: String? { return nil }
    var bankLogo: UIImage? { return nil }
    var cardDesign: UIImage? { return nil }
}


