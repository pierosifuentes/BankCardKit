//
//  CardInputTextField.swift
//  BankCardKit
//
//  Created by Piero on 27/12/17.
//

import UIKit

open class CardInputTextField: UITextField {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setupOnInit()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupOnInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupOnInit()
    }
    
    weak var cardInputDelegate: CardInputTextFieldDelegate?
    var type: InputType! = .cardNumber {
        willSet {
            OperationQueue.main.addOperation {
                self.setup(type: newValue)
            }
        }
    }
    
    private func setupOnInit() {
        self.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: .editingChanged)
        self.addTarget(self, action: #selector(textFieldEditingDidEnd(_:)), for: .editingDidEnd)
    }
    
    private func setup(type: InputType) {
        
    }
    
    open func validate() {
        
    }
    
    @objc private func textFieldEditingDidChange(_ textField: UITextField) {
        self.cardInputDelegate?.inputTextFieldDidChange(self)
    }
    @objc private func textFieldEditingDidEnd(_ textField: UITextField) {
        self.cardInputDelegate?.inputTextFieldDidEnd(self)
    }
}


//extension CardInputTextField: CardInputTextFieldDelegate {
//
//    public func inputTextFieldDidChange(_ textField: UITextField) {
//
//    }
//
//    public func inputTextFieldDidComplete(_ textField: UITextField) {
//
//    }
//}

