//
//  ViewControllerB1.swift
//  Module7
//
//  Created by Sergey Chistov on 19.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

protocol ColorInfoDelegate {
    func setColor(_ value: UIColor, _ name: String)
}

class ViewControllerB1: UIViewController, ColorInfoDelegate {

    var colorValue = UIColor(named: "Color.Green")
    var colorName = "зеленый"

    @IBOutlet weak var colorLabel: UILabel!

    override func viewDidLoad() {
        guard let color = colorValue else { return }
        setColor(color, colorName)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewControllerB2, segue.identifier == "showSelect" {
            guard let color = colorValue else { return }
            vc.setColor(color, colorName)
            vc.delegate = self
        }
    }

    @IBAction func onChange() {
        performSegue(withIdentifier: "showSelect", sender: nil)
    }

    func setColor(_ value: UIColor, _ name: String) {
        colorValue = value
        colorName = name
        colorLabel.textColor = colorValue
        colorLabel.text = "Выбран \(colorName)"
    }

}
