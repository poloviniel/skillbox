//
//  ViewController.swift
//  Module6-2
//
//  Created by Sergey Chistov on 04.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var numberTextField: UITextField!

    @IBAction func onCalculate(_ sender: Any) {
        let number = Int(numberTextField.text ?? "")
        if (number != nil) {
            powerLabel.text = "\(pow(2, number!))"
        } else {
            powerLabel.text = "Please enter number"
        }
    }
}

