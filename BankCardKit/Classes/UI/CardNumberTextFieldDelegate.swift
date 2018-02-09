//
//  CardNumberTextFieldDelegate.swift
//  BankCardKit
//
//  Created by Piero on 27/12/17.
//

import Foundation

@objc
public protocol CardInputTextFieldDelegate {
    func inputTextFieldDidChange(_ textField: UITextField)
    func inputTextFieldDidEnd(_ textField: UITextField)
    func inputTextFieldShowError(_ textField: UITextField, view: UIView?)
    @objc optional func inputTextFieldDidReachMaxSize(_ textField: UITextField)
    @objc optional func inputTextFieldDidLostFocus(_ textField: UITextField)
}
