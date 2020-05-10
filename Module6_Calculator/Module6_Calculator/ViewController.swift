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
        m_expr = .number(0)
    }

    @IBAction func onNumber(_ sender: UIButton) {
        guard let symbol = sender.titleLabel?.text else { return }
        var str = m_resetDisplay ? "" : display.text ?? ""
        m_resetDisplay = false

        if symbol != "," && str == "0" {
            str = symbol
        } else {
            str += symbol == "," ? "." : symbol
        }

        display.text = str
        let newNumber = Double(str) ?? 0

        switch m_expr {
        case .number: m_expr = .number(newNumber)
        case .negate: m_expr = .number(newNumber)
        case let .add(value1, _): m_expr = .add(value1, .number(newNumber))
        case let .dec(value1, _): m_expr = .dec(value1, .number(newNumber))
        case let .mul(value1, _): m_expr = .mul(value1, .number(newNumber))
        case let .div(value1, _): m_expr = .div(value1, .number(newNumber))
        case let .mod(value1, _): m_expr = .mod(value1, .number(newNumber))
        }
    }

    @IBAction func onOperator(_ sender: UIButton) {
        guard let op = sender.titleLabel?.text else { return }
        onOperator(op)
    }

    func onOperator(_ op: String) {
        let newNumber = Expression.evaluate(m_expr)
        display.text = newNumber.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.f", newNumber) : String(newNumber)

        switch op {
        case "±": m_expr = .negate(.number(newNumber));
            onOperator("=") // такова унарная природа этого оператора
        case "+": m_expr = .add(.number(newNumber), .number(newNumber))
        case "-": m_expr = .dec(.number(newNumber), .number(newNumber))
        case "×": m_expr = .mul(.number(newNumber), .number(newNumber))
        case "÷": m_expr = .div(.number(newNumber), .number(newNumber))
        case "%": m_expr = .mod(.number(newNumber), .number(newNumber))
        case "=": m_expr = .number(newNumber)
        default:
            break
        }
        m_resetDisplay = true;
    }

    indirect enum Expression {
        case number(Double)
        case negate(Expression)
        case add(Expression, Expression)
        case dec(Expression, Expression)
        case mul(Expression, Expression)
        case div(Expression, Expression)
        case mod(Expression, Expression)

        static func evaluate(_ expr: Expression) -> Double {
            switch expr {
            case let .number(value): return value
            case let .negate(value): return -evaluate(value)
            case let .add(value1, value2): return evaluate(value1) + evaluate(value2)
            case let .dec(value1, value2): return evaluate(value1) - evaluate(value2)
            case let .mul(value1, value2): return evaluate(value1) * evaluate(value2)
            case let .div(value1, value2): return evaluate(value1) / evaluate(value2)
            case let .mod(value1, value2): return evaluate(value1).truncatingRemainder(dividingBy: evaluate(value2))
            }
        }

    }

    private var m_expr: Expression = .number(0)
    private var m_resetDisplay: Bool = false
}

