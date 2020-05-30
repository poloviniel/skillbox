//
//  ToolbarExt.swift
//  Module7_additional
//
//  Created by Sergey Chistov on 30.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

protocol ToolbarExtDelegate {
    func onItemsCountChanged(_ value: Int)
}

@IBDesignable
class ToolbarExt: UIToolbar {
    var extDelegate: ToolbarExtDelegate?
    private let maxAmount = 6
    private var cachedItemsCount = 0

    @IBInspectable var itemsCount: Int {
        get {
            return cachedItemsCount
        }
        set {
            cachedItemsCount = min(max(0, newValue), maxAmount)
            if let extDelegate = extDelegate {
                extDelegate.onItemsCountChanged(cachedItemsCount)
            }
        }
    }

}
