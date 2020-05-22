//
//  ViewControllerA1.swift
//  Module7
//
//  Created by Sergey Chistov on 19.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class ViewControllerA1: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewControllerA2 /*, segue.identifier == ""*/ {
            vc.backColor = (sender as? ButtonExt)?.colorValue ?? UIColor.black
        }
    }
}

