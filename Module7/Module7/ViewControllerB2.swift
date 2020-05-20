//
//  ViewControllerB2.swift
//  Module7
//
//  Created by Sergey Chistov on 19.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class ViewControllerB2: UIViewController {
    var delegate: ColorInfoDelegate?
    var colorValue = UIColor(named: "Color.Green")
    var colorName = "зеленый"

    @IBOutlet weak var colorLabel: UILabel!

    @IBAction func onChange(_ sender: UIButton) {
        guard let color = sender.value(forKey: "colorValue") as? UIColor else {return }
        guard let str = sender.value(forKey: "colorString") as? String else {return }
        if let delegate = delegate {
            delegate.setColor(color, str)
            dismiss(animated: true, completion: nil)
        }
    }

    func setColor(_ value: UIColor, _ name: String) {
        colorValue = value
        colorName = name
    }

    override func viewDidLoad() {
        colorLabel.textColor = colorValue
        colorLabel.text = "Выбран \(colorName)"
    }

}

class ButtonExt: UIButton {
    @IBInspectable var colorString = ""
    @IBInspectable var colorValue = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
}
