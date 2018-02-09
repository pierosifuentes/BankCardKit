//
//  BCKRawCard.swift
//  BankCardKit
//
//  Created by Piero on 9/01/18.
//

import Foundation

struct BCKRawCard: BCKCard {
    
    var cardNumber: BCKCardNumber
    
    var CVC: BCKVerificationCode?
    
    var expirationDate: BCKExpirationDate
    
    var account: BCKAccountType
    
    var cardholderName: String?
    
    var cardBrand: BCKCardBrand
    
    var bankName: String?
    
    var bankLogo: UIImage?
    
    var cardDesign: UIImage?
    
    var userInfo: [AnyHashable : Any]?
    
    init(cardNumber: BCKCardNumber, CVC: BCKVerificationCode?, expirationDate: BCKExpirationDate, account: BCKAccountType, cardholderName: String?, cardBrand: BCKCardBrand? = nil, bankName: String?, bankLogo: UIImage?, cardDesign: UIImage?, userInfo: [AnyHashable : Any]? = nil) {
        
        if let guardRawCardBrand = cardBrand, cardNumber.isValid(for: guardRawCardBrand, account: account) {
            self.cardBrand = guardRawCardBrand
        } else {
            self.cardBrand = cardNumber.cardBrand(forAccount: account)
        }
        
        self.cardNumber = cardNumber
        self.CVC = CVC
        self.expirationDate = expirationDate
        self.account = account
        self.cardholderName = cardholderName
        self.bankName = bankName
        self.bankLogo = bankLogo
        self.cardDesign = cardDesign
        self.userInfo = userInfo
    }
    
    init?(cardNumber: String, CVC: String?, expirationDate: String, account: BCKAccountType, cardholderName: String?, cardBrand: BCKCardBrand? = nil, bankName: String?, bankLogo: UIImage?, cardDesign: UIImage?, userInfo: [AnyHashable : Any]? = nil) {
        guard let guardCardNumber = BCKCardNumber(cardDigits: cardNumber, splitPattern: cardBrand?.splitPattern ?? [4, 4, 4, 4]), let guardExpirationDate = BCKExpirationDate(string: expirationDate) else { return nil }
        var verificationCode: BCKVerificationCode? = nil
        if let guardCVC = CVC {
            verificationCode = BCKVerificationCode(code: guardCVC, lenght: cardBrand?.CVCMinLength ?? 4)
        }
        self.init(cardNumber: guardCardNumber, CVC: verificationCode, expirationDate: guardExpirationDate, account: account, cardholderName: cardholderName, cardBrand: cardBrand, bankName: bankName, bankLogo: bankLogo, cardDesign: cardDesign, userInfo: userInfo)
        
    }
    
    static func create(cardNumber: BCKCardNumber, CVC: BCKVerificationCode?, expirationDate: BCKExpirationDate, account: BCKAccountType, cardholderName: String?, cardBrand: BCKCardBrand? = nil, bankName: String?, bankLogo: UIImage?, cardDesign: UIImage?, userInfo: [AnyHashable : Any]? = nil) -> BCKCard? {
        return BCKRawCard(cardNumber: cardNumber, CVC: CVC, expirationDate: expirationDate, account: account, cardholderName: cardholderName, cardBrand: cardBrand, bankName: bankName, bankLogo: bankLogo, cardDesign: cardDesign, userInfo: userInfo)
    }
    
    static func create(cardNumber: String, CVC: String?, expirationDate: String, account: BCKAccountType, cardholderName: String?, cardBrand: BCKCardBrand? = nil, bankName: String?, bankLogo: UIImage?, cardDesign: UIImage?, userInfo: [AnyHashable : Any]? = nil) -> BCKCard? {
        return BCKRawCard(cardNumber: cardNumber, CVC: CVC, expirationDate: expirationDate, account: account, cardholderName: cardholderName, cardBrand: cardBrand, bankName: bankName, bankLogo: bankLogo, cardDesign: cardDesign, userInfo: userInfo)
    }
}
