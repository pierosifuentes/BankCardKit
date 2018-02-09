//
//  BCKRawCardBrand.swift
//  iOSBankCardFramework
//
//  Created by Piero on 13/11/17.
//

import Foundation

public class BCKRawCardBrand: ExpressibleByIntegerLiteral, BCKCardBrand, Equatable {
    
    public typealias IntegerLiteralType = Int
    
    var rawValue: Int = 0
    
    public var name: String
    
    public var creditBinDigits: Set<Int>
    
    public var debitBinDigits: Set<Int>
    
    public var cardNumberMinLenght: Int
    
    public var cardNumberFormattedMinLenght: Int
    
    public var CVCMinLength: Int
    
    public var splitPattern: [Int]
    
    public var logo: UIImage?
    
    public static let nonspecific = BCKRawCardBrand(integerLiteral: 0)
    public static let visa = BCKRawCardBrand(integerLiteral: 1)
    public static let master = BCKRawCardBrand(integerLiteral: 2)
    public static let amex = BCKRawCardBrand(integerLiteral: 3)
    public static let unionpay = BCKRawCardBrand(integerLiteral: 4)
    public static let diners = BCKRawCardBrand(integerLiteral: 5)
    public static let jcb = BCKRawCardBrand(integerLiteral: 6)
    public static let discover = BCKRawCardBrand(integerLiteral: 7)
    public static let inter = BCKRawCardBrand(integerLiteral: 8)
    public static let insta = BCKRawCardBrand(integerLiteral: 9)
    public static let maestro = BCKRawCardBrand(integerLiteral: 10)
    public static let uatp = BCKRawCardBrand(integerLiteral: 11)
    
    public required convenience init(integerLiteral value: Int) {
        switch value {
        case visaBrandKey:
            self.init(integerLiteral: value, name: "Visa", creditBins: Set([4]), deditBins: Set([421355, 454777, 411074, 455170]), cardNumberMinLenght: 16, cardNumberFormattedMinLenght: 19, CVCMinLength: 3, splitPattern: [4, 4, 4, 4], logo: nil)
        case masterBrandKey:
            self.init(integerLiteral: value, name: "MasterCard", creditBins: Set(51...55).union(Set(2221...2720)), deditBins: Set(), cardNumberMinLenght: 16, cardNumberFormattedMinLenght: 19, CVCMinLength: 3, splitPattern: [4, 4, 4, 4], logo: nil)
        case amexBrandKey:
            self.init(integerLiteral: value, name: "American Express", creditBins: Set([34, 37]), deditBins: Set(), cardNumberMinLenght: 15, cardNumberFormattedMinLenght: 17, CVCMinLength: 4, splitPattern: [4, 6, 5], logo: nil)
        case unionpayBrandKey:
            self.init(integerLiteral: value, name: "China UnionPay", creditBins: Set([62]), deditBins: Set(), cardNumberMinLenght: 16, cardNumberFormattedMinLenght: 19, CVCMinLength: 3, splitPattern: [4, 4, 4, 4], logo: nil)
        case dinersBrandKey:
            self.init(integerLiteral: value, name: "Diners Club", creditBins: Set(300...305).union(Set([36, 38, 39, 54, 55, 309, 2014, 2149])), deditBins: Set(), cardNumberMinLenght: 14, cardNumberFormattedMinLenght: 16, CVCMinLength: 3, splitPattern: [4, 6, 4], logo: nil)
        case jcbBrandKey:
            self.init(integerLiteral: value, name: "JCB", creditBins: Set(3528...3589).union(Set([3088, 3096, 3112, 3158, 3337])), deditBins: Set(), cardNumberMinLenght: 16, cardNumberFormattedMinLenght: 19, CVCMinLength: 3, splitPattern: [4, 4, 4, 4], logo: nil)
        case discoverBrandKey:
            self.init(integerLiteral: value, name: "Discover", creditBins: Set(644...649).union(Set([6011]) ).union(Set([65])).union(Set(622126...622925)), deditBins: Set(), cardNumberMinLenght: 16, cardNumberFormattedMinLenght: 19, CVCMinLength: 3, splitPattern: [4, 4, 4, 4], logo: nil)
        case interBrandKey:
            self.init(integerLiteral: value, name: "InterPayment", creditBins: Set([636]), deditBins: Set(), cardNumberMinLenght: 16, cardNumberFormattedMinLenght: 19, CVCMinLength: 3, splitPattern: [4, 4, 4, 4], logo: nil)
        case instaBrandKey:
            self.init(integerLiteral: value, name: "InstaPayment", creditBins: Set(637...639), deditBins: Set(), cardNumberMinLenght: 16, cardNumberFormattedMinLenght: 19, CVCMinLength: 3, splitPattern: [4, 4, 4, 4], logo: nil)
        case maestroBrandKey:
            self.init(integerLiteral: value, name: "Maestro", creditBins: Set([50]).union(Set(56...58)).union(Set([6])), deditBins: Set(), cardNumberMinLenght: 16, cardNumberFormattedMinLenght: 19, CVCMinLength: 3, splitPattern: [4, 4, 4, 4], logo: nil)
        case uatpBrandKey:
            self.init(integerLiteral: value, name: "UATP", creditBins: Set([1]), deditBins: Set(), cardNumberMinLenght: 15, cardNumberFormattedMinLenght: 19, CVCMinLength: 3, splitPattern: [4, 4, 4, 4], logo: nil)
        default:
            self.init(integerLiteral: value, name: "Unknown", creditBins: Set([]), deditBins: Set([]), cardNumberMinLenght: 16, cardNumberFormattedMinLenght: 19, CVCMinLength: 0, splitPattern: [4, 4, 4, 4], logo: nil)
        }
    }
    
    public required init(integerLiteral value: Int, name: String, creditBins: Set<Int>, deditBins: Set<Int>, cardNumberMinLenght: Int, cardNumberFormattedMinLenght: Int, CVCMinLength: Int, splitPattern: [Int], logo: UIImage?) {
        self.rawValue = value
        self.name = name
        self.creditBinDigits = creditBins
        self.debitBinDigits = deditBins
        self.cardNumberMinLenght = cardNumberMinLenght
        self.cardNumberFormattedMinLenght = cardNumberFormattedMinLenght
        self.CVCMinLength = CVCMinLength
        self.splitPattern = splitPattern
        self.logo = logo
    }
    
    public static func ==(lhs: BCKRawCardBrand, rhs: BCKRawCardBrand) -> Bool {
        return lhs.name == rhs.name &&
            lhs.creditBinDigits == rhs.creditBinDigits &&
            lhs.debitBinDigits == lhs.debitBinDigits
    }
}
