//
//  ViewControllerC2.swift
//  Module7
//
//  Created by Sergey Chistov on 20.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class ViewControllerC2: UIViewController {

    weak var delegate: ColorDelegate?

    @IBAction func onButton(_ sender: ButtonExt) {
        guard let color = sender.value(forKey: "colorValue") as? UIColor else { return }
        if let delegate = delegate {
            delegate.setColor(color)
        }
    }

    func setColor(_ value: UIColor) {
        self.view.backgroundColor = value
    }
}
