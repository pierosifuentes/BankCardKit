//
//  BCKFormaterMask.swift
//  BankCardKit
//
//  Created by Piero on 12/01/18.
//

import Foundation

public struct BCKFormaterMask {
    enum MaskDirection {
        case toRight
        case toLeft
    }
    var lenght: Int = 12
    var direction: MaskDirection = .toRight
    var attributes: [NSAttributedStringKey : Any]?
    var plain: String? = "●"
    var attributed: NSAttributedString? {
        guard let guardPlainMask = plain else { return nil }
        return NSAttributedString(string: guardPlainMask, attributes: attributes)
    }
    var isValid: Bool {
        guard let mask = plain, mask.count > 0, mask != " " else { return false }
        return true
    }
    public static let `default` = BCKFormaterMask(lenght: 12, direction: .toRight, attributes: nil, plain: "●")
}
