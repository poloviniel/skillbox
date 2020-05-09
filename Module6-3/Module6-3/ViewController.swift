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

    @IBAction func onCalculate() {
        enum MathError: Error {
            case wrongOperand, wrongOperator, divisionByZero
        }

        do {
            guard var op = Operator(rawValue: operandTextField.text ?? "") else { throw MathError.wrongOperator }

            let left: Double
            if op == .Dec && leftTextField.text ?? "" == "" {
                op = .Negate
                left = 0
            } else {
                guard let arg = Double(leftTextField.text ?? "") else { throw MathError.wrongOperand }
                left = arg
            }

            guard let right = Double(rightTextField.text ?? "") else { throw MathError.wrongOperand }
            if op == .Div && right == 0 { throw MathError.divisionByZero }
            sumLabel.text = String(Operator.apply(left, right, op))
        } catch {
            sumLabel.text = "Wrong parameters"
        }
    }

    enum Operator: String {
        case Negate = "--"
        case Add = "+"
        case Dec = "-"
        case Mul = "*"
        case Div = "/"
        case Mod = "%"

        static func apply(_ value1: Double, _ value2: Double, _ op: Operator) -> Double {
            switch op {
            case .Negate: return -value2
            case .Add: return value1 + value2
            case .Dec: return value1 - value2
            case .Mul: return value1 * value2
            case .Div: return value1 / value2
            case .Mod: return ((value1 / value2) - (value1 / value2).rounded(.towardZero)) * value2
            }
        }
    } // enum
}

