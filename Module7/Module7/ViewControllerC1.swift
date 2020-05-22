//
//  ViewControllerC1.swift
//  Module7
//
//  Created by Sergey Chistov on 19.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

protocol ColorDelegate: class {
    func setColor(_ value: UIColor)
}

class ViewControllerC1: UIViewController, ColorDelegate {

    private weak var childViewController: ViewControllerC2?

    @IBAction func onButton(_ sender: ButtonExt) {
        guard let color = sender.value(forKey: "colorValue") as? UIColor else { return }
        if let child = childViewController {
            child.setColor(color)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewControllerC2, segue.identifier == "embed" {
            vc.delegate = self
            childViewController = vc
        }
    }

    func setColor(_ value: UIColor) {
        self.view.backgroundColor = value
    }
}
