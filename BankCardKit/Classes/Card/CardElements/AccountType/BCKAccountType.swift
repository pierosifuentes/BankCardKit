//
//  BCKAccountType.swift
//  Alamofire
//
//  Created by Piero on 21/11/17.
//

import Foundation

public enum BCKAccountType {
    case credit, debit
    static let all: [BCKAccountType] = [.debit, .credit]
}

