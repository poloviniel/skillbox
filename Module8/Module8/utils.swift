//
//  utils.swift
//  Module8
//
//  Created by Sergey Chistov on 10.06.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

func makeSafeRect(_ view: UIView) -> CGRect {
    let rect = view.frame
    let insets = view.safeAreaInsets
    let x = rect.origin.x + insets.left
    let y = rect.origin.y + insets.top
    let w = rect.size.width - insets.left - insets.right
    let h = rect.size.height - insets.top - insets.bottom
    return CGRect(x: x, y: y, width: w, height: h)
}
