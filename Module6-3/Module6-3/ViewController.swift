//
//  ViewController.swift
//  Module6-3
//
//  Created by Sergey Chistov on 04.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var rightTextField: UITextField!
    @IBOutlet weak var operandTextField: UITextField!

    @IBAction func onCalculate(_ sender: Any) {
        let left = Int(leftTextField.text!)
        let right = Int(rightTextField.text!)
        let op = operandTextField.text!
        if (left == nil || right == nil) {
            onError()
            return
        }

        var fun: (Int, Int) -> Int
        switch op {
        case "+": fun = { (_ a: Int, _ b: Int) -> Int in a + b }
        case "-": fun = { (_ a: Int, _ b: Int) -> Int in a - b }
        case "*": fun = { (_ a: Int, _ b: Int) -> Int in a * b }
        case "/": fun = { (_ a: Int, _ b: Int) -> Int in a / b }
        default:
            onError()
            return
        }

        sumLabel.text = String(fun(left!, right!))
    }

    func onError() {
        sumLabel.text = "Wrong parameters"
    }
}

