//
//  BCKCardNumberFormater.swift
//  BankCardKit
//
//  Created by Piero on 10/01/18.
//

import Foundation

open class BCKCardNumberFormater {
    
    static open func formatOnEditing(number: String, pattern: [Int]) -> String? {
        guard number.isEmpty == false && pattern.isEmpty == false else { return nil }
        let cardNumber = number.digitsUnformated
        var formattedNumber: String = ""
        var xIndex = 0
        var character: Character
        var groupSize = pattern.first!
        var splitPatternIndex = 0
        while xIndex < cardNumber.count {
            let index = cardNumber.index(cardNumber.startIndex, offsetBy: xIndex)
            character = cardNumber[index]
            
            if xIndex != 0 && splitPatternIndex % groupSize == 0 {
                splitPatternIndex = 0
                formattedNumber.append(" ")
                if let nextIndex = pattern.index(of: groupSize), nextIndex + 1 < pattern.count {
                    groupSize = pattern[pattern.index(of: groupSize)! + 1]
                }
            }
            formattedNumber.append(character)
            xIndex += 1
            splitPatternIndex += 1
        }
        
        return formattedNumber
    }
    
    static open func format(number: String, with mask: BCKFormaterMask, splitPattern: [Int], numberAttributes: [NSAttributedStringKey : Any]?) -> NSAttributedString? {
        let cardNumber = number.digitsUnformated
        let result = splitPattern.reduce(0, { x, y in x + y })
        guard mask.isValid, cardNumber.isEmpty == false, splitPattern.isEmpty == false, cardNumber.count == result, cardNumber.count > mask.lenght else { return nil }
        return self.split(cardNumber: cardNumber, pattern: splitPattern, mask: mask, numberAttributes: numberAttributes)
    }
    
    static open func format(number: String, with mask: BCKFormaterMask, splitPattern: [Int]) -> String? {
        let cardNumber = number.digitsUnformated
        let result = splitPattern.reduce(0, { x, y in x + y })
        guard mask.isValid, cardNumber.isEmpty == false, splitPattern.isEmpty == false, cardNumber.count == result, cardNumber.count >= mask.lenght else { return nil }
        return self.split(cardNumber: number, pattern: splitPattern, mask: mask)
    }
    
    static private func split(cardNumber: String, pattern: [Int], mask: BCKFormaterMask, numberAttributes: [NSAttributedStringKey : Any]?) ->  NSMutableAttributedString? {
        guard cardNumber.isEmpty == false && pattern.isEmpty == false else { return nil }
        let formattedNumber = NSMutableAttributedString()
        var charCounter = 0
        for groupSize in pattern {
            let startIndex = cardNumber.index(cardNumber.startIndex, offsetBy: charCounter)
            let endIndex = cardNumber.index(cardNumber.startIndex, offsetBy: charCounter + groupSize - 1)
            for character in cardNumber[startIndex...endIndex] {
                if mask.direction == .toRight {
                    let attributedCharacter = (mask.isValid && mask.lenght > charCounter) ? mask.attributed! : NSAttributedString(string: String(character), attributes: numberAttributes)
                    formattedNumber.append(attributedCharacter)
                } else {
                    let attributedCharacter = (mask.isValid && charCounter < mask.lenght) ? mask.attributed! : NSAttributedString(string: String(character), attributes: numberAttributes)
                    formattedNumber.append(attributedCharacter)
                }
            }
            charCounter += groupSize
            formattedNumber.append(NSAttributedString(string:" ", attributes: nil))
        }
        return formattedNumber
    }
    
    static private func split(cardNumber: String, pattern: [Int], mask: BCKFormaterMask) -> String? {
        guard cardNumber.isEmpty == false && pattern.isEmpty == false else { return nil }
        var formattedNumber = ""
        var charCounter = 0
        for groupSize in pattern {
            let startIndex = cardNumber.index(cardNumber.startIndex, offsetBy: charCounter)
            let endIndex = cardNumber.index(cardNumber.startIndex, offsetBy: charCounter+groupSize-1)
            for character in cardNumber[startIndex...endIndex] {
                if mask.direction == .toRight {
                    let character = (mask.isValid && mask.lenght > charCounter) ? mask.plain! : String(character)
                    formattedNumber.append(character)
                } else {
                    let character = (mask.isValid && charCounter < mask.lenght) ? mask.plain! : String(character)
                    formattedNumber.append(character)
                }
            }
            charCounter += groupSize
            formattedNumber.append(" ")
        }
        return formattedNumber
    }
    
    public func unformat(cardNumber: String) -> String {
        return cardNumber.digitsUnformated
    }
}
