//
//  ViewController.swift
//  Module6-1
//
//  Created by Sergey Chistov on 04.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var namesLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!

    @IBAction func onTextChanged(_ sender: Any) {
        addButton.isEnabled = !nameTextField.text!.isEmpty
    }

    @IBAction func onButtonTouch(_ sender: Any) {
        var str = namesLabel.text!
        str += str.isEmpty ? nameTextField.text! : " " + nameTextField.text!
        namesLabel.text = str
        nameTextField.text = ""
        addButton.isEnabled = false
    }

    override func viewDidLoad() {
        addButton.isEnabled = false
    }

}

