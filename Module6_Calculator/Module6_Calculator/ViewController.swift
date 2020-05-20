//
//  ViewController.swift
//  Module6_Calculator
//
//  Created by Sergey Chistov on 07.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        reset()
    }

    @IBAction func reset() {
        display.text = "0"
        expression = ""
        resetText = false
    }

    @IBAction func onNumber(_ sender: UIButton) {
        guard let symbol = sender.titleLabel?.text else { return }
        if resetText {
            resetText = false
            text = "0"
        }

        if symbol != "," && Double(text) == 0 {
            text = symbol // цифра заменяет единственный ноль
        } else if symbol == ",", let last = text.last {
            text += last == "." ? "" : "." // точка может быть только одна
        } else {
            text += symbol
        }

        display.text = text
    }

    @IBAction func onOperator(_ sender: UIButton) {
        guard let op = sender.titleLabel?.text else { return }
        onOperator(op)
    }

    func onOperator(_ op: String) {
        if op == "±" {
            if text.starts(with: "-") {
                text.removeFirst()
            } else {
                text.insert("-", at:text.startIndex)
            }
            display.text = text
            return
        }

        expression += text
        if let last = text.last {
            if last == "." {
                expression += "0" // если не закрыть точку нулём, NSExpression падает
            }
        }
        if expression.hasPrefix("modulus") {
            expression = "(\(expression)))" // куда ж без костыля. без костыля никуда.
            // внешняя пара скобок для того, чтобы hasPrefix("modulus") больше не срабатывал
        }

        if op == "=" {
            print(expression)
            let expr = NSExpression(format: expression)
            if let result = expr.expressionValue(with: nil, context: nil) as? NSNumber {
                text = result.stringValue
                display.text = text
            }
            expression = ""
            resetText = true
            return
        }

        resetText = true

        switch op {
        case "+": expression += " + "
        case "-": expression += " - "
        case "×": expression += " * "
        case "÷": expression += " / "
        case "%": expression = "modulus:by:(\(expression), " // MSExpression не понимает %
        default:
            break
        }
    }

    private var text: String = "0"
    private var expression: String = ""
    private var resetText: Bool = false
}

