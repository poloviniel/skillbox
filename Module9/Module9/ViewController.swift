//
//  ViewController.swift
//  Module9
//
//  Created by Sergey Chistov on 13.06.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var height: CGFloat = 0

    override func viewDidLoad() {
        height = labelHeight.constant
    }

    @IBOutlet weak var labelHeight: NSLayoutConstraint!

    @IBAction func onButton(_ sender: ButtonExt) {
        labelHeight.constant += height * CGFloat(sender.increment)
    }

}

class ButtonExt: UIButton {
    @IBInspectable var increment: Int = 0
}
