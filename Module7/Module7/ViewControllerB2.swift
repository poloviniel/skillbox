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
        delegate?.setColor(color, str)
        dismiss(animated: true, completion: nil)
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
    @IBInspectable var colorString = "" {
        didSet {
            // не работает, кнопка не инициализирована
            self.titleLabel?.text = colorString
        }
    }

    @IBInspectable var colorValue = UIColor.black {
        didSet {
            // не работает, кнопка не инициализирована
            self.titleLabel?.textColor = colorValue
        }
    }
}
