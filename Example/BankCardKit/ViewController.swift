//
//  ViewController.swift
//  BankCardKit
//
//  Created by piero9212@gmail.com on 12/13/2017.
//  Copyright (c) 2017 piero9212@gmail.com. All rights reserved.
//

import UIKit
import BankCardKit

struct MyCustomVisa: BCKCardBrand {
    var name: String {
        return "Custom Visa"
    }
    
    var creditBinDigits: Set<Int> {
        return Set([4,10])
    }
    
    var debitBinDigits: Set<Int> {
        return Set([433])
    }
    
    var cardNumberMinLenght: Int {
        return 16
    }
    
    var cardNumberFormattedMinLenght: Int {
        return self.cardNumberFormattedMinLenght + self.splitPattern.count - 1
    }
    
    var CVCMinLength: Int {
        return 4
    }
    
    var splitPattern: [Int] {
        return [4, 4, 4, 4]
    }
    
    var logo: UIImage?
    
    var active: Bool
}

class ViewController: UIViewController {
    
    /// IBOutlets
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var cardBrandLabel: UILabel!
    @IBOutlet weak var expirationDateTextField: UITextField!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    
    /// Properties
    var cardBrand: BCKCardBrand? {
        didSet {
            self.cardBrandLabel?.text = cardBrand?.name
        }
    }
    let customVisa = MyCustomVisa(logo: nil, active: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BCKBrandManager.shared.register(brand: self.customVisa)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cardNumberTextEditing(_ sender: UITextField) {
        guard let text = sender.text else { return }
        let brand = text.cardBrand(accountType: .credit)
        self.cardBrand = brand
        sender.text = BCKCardNumberFormater.formatOnEditing(number: text, pattern: brand.splitPattern)
    }
    @IBAction func expirationDateTextEditing(_ sender: UITextField) {
        guard let text = sender.text else { return }
        sender.text = ExpirationDateFormater.formatOnEditing(date: text, separator: "-", leadingZero: false)
    }
    @IBAction func verificationCodeTextEditing(_ sender: UITextField) {
//        guard let text = sender.text else { return }
        //sender.text = VerificationCodeFormater.form
    }
    
}

