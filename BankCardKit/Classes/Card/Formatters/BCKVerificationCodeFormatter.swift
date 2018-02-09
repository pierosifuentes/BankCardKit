//
//  BCKVerificationCodeFormater.swift
//  BankCardKit
//
//  Created by Piero on 10/01/18.
//

import Foundation

open class BCKVerificationCodeFormater {
  
    static open func format(code: String, mask: BCKFormaterMask) -> String? {
        let verificationCode = code.digitsUnformated
        guard mask.isValid, verificationCode.isEmpty == false, code.count >= mask.lenght else { return nil }
        var charCounter = 0
        var formatedCode = ""
        for character in verificationCode {
            if charCounter < mask.lenght {
                formatedCode.append(mask.plain!)
                charCounter += 1
            } else {
                formatedCode.append(String(character))
            }
        }
        return formatedCode
    }
    
    static open func format(code: String, mask: BCKFormaterMask, codeAttributes: [NSAttributedStringKey : Any]?) -> NSMutableAttributedString? {
        let verificationCode = code.digitsUnformated
        guard mask.isValid, verificationCode.isEmpty == false, code.count >= mask.lenght else { return nil }
        var charCounter = 0
        let formatedCode = NSMutableAttributedString()
        for character in verificationCode {
            if charCounter < mask.lenght {
                formatedCode.append(mask.attributed!)
                charCounter += 1
            } else {
                formatedCode.append(NSAttributedString(string: String(character), attributes: codeAttributes))
            }
        }
        return formatedCode
    }
    
    static open func unformat(code: String) -> String {
        return code.digitsUnformated
    }
    
}
