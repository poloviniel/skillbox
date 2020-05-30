//
//  CustomContainerController.swift
//  Module7_additional
//
//  Created by Sergey Chistov on 29.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class CustomContainerController: UIViewController, ToolbarExtDelegate {

    @IBOutlet weak var toolbar: ToolbarExt!
    @IBOutlet weak var label: UILabel!

    private var cache: Array<(button: UIBarButtonItem, view: UIView)> = []
    private let colors = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.cyan, UIColor.blue]

    /*
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
       super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
       itemsCount = 0
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        if let itemsCount = decoder.decodeObject() as? Int {
            self.itemsCount = itemsCount
        } else {
            self.itemsCount = 0
        }
    }
     */

    override func viewDidLoad() {
        toolbar.extDelegate = self
        updateChildCount(toolbar.itemsCount)
    }

    func onItemsCountChanged(_ value: Int) {
        updateChildCount(value)
    }

    func updateChildCount(_ amount: Int) {
        while amount > cache.count {
            let button = UIBarButtonItem(image: UIImage(systemName: "circle.fill"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(CustomContainerController.onButton))
            button.image = UIImage(systemName: "circle.fill")
            button.tintColor = colors[cache.count]
            button.tag = cache.count

            let view = UIView()
            view.backgroundColor = colors[cache.count]
            self.view.addSubview(view)
            cache.append((button: button, view: view))
        }

        if toolbar == nil {
            return
        }

        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        var items: [UIBarButtonItem] = [space]
        for data in cache[0..<amount] {
            items.append(data.button)
            items.append(space)
        }
        toolbar.setItems(items, animated: false)

        for (i, data) in cache.enumerated() {
            data.view.isHidden = i >= amount
        }

        updateViews();
    }

    func updateViews() {
        let visibleCount = cache.reduce(0, { sum, v in sum + (v.view.isHidden ? 0 : 1) })
        label.isHighlighted = visibleCount == 0
        if visibleCount == 0
        {
            return
        }

        let parent = self.view.frame
        let height = (parent.height - toolbar.frame.height) / CGFloat(visibleCount)
        var idx = 0
        for data in cache {
            if data.view.isHidden {
                continue
            }
            let rect = CGRect(x: 0, y: toolbar.frame.height + CGFloat(idx) * height, width: parent.width, height: height)
            data.view.frame = rect
            idx += 1
        }
    }

    @objc
    func onButton(_ sender: UIBarButtonItem) {
        let disabled = sender.tintColor == UIColor.gray
        sender.tintColor = disabled ? colors[sender.tag] : UIColor.gray
        cache[sender.tag].view.isHidden = !disabled
        updateViews()
    }

}
