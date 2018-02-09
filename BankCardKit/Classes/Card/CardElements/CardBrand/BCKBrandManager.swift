//
//  BCKBrandManager.swift
//  BankCardKit
//
//  Created by Piero on 15/01/18.
//

import Foundation

internal let nonspecificBrandKey = 0
internal let visaBrandKey = 1
internal let masterBrandKey = 2
internal let amexBrandKey = 3
internal let unionpayBrandKey = 4
internal let dinersBrandKey = 5
internal let jcbBrandKey = 6
internal let discoverBrandKey = 7
internal let interBrandKey = 8
internal let instaBrandKey = 9
internal let maestroBrandKey = 10
internal let uatpBrandKey = 11

public class BCKBrandManager {
    
    public static let shared: BCKBrandManager = BCKBrandManager()
    private(set) var registeredBrands: [BCKCardBrand] = []
    
    private init () {
        self.registeredBrands = [BCKRawCardBrand.visa, BCKRawCardBrand.master, BCKRawCardBrand.amex, BCKRawCardBrand.unionpay, BCKRawCardBrand.diners, BCKRawCardBrand.jcb, BCKRawCardBrand.discover, BCKRawCardBrand.inter, BCKRawCardBrand.insta, BCKRawCardBrand.maestro, BCKRawCardBrand.uatp]
        
    }
    
    public func register(brand: BCKCardBrand) {
        let contains = self.registeredBrands.contains { (b) -> Bool in
            return b.name == brand.name &&
                b.creditBinDigits == brand.creditBinDigits &&
                b.debitBinDigits == brand.debitBinDigits
        }
        guard !contains else {
            print("CONTAINS!!!!")
            return
        }
        self.registeredBrands.append(brand)
    }
}

