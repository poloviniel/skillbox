//
//  ViewControllerB.swift
//  Module8
//
//  Created by Sergey Chistov on 04.06.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class ViewControllerB: UIViewController {

    let images = ["Jojo young", "Danny", "Iggy", "Remove Kebab", "Connection", "Berries", "Gnome", "Armstrong", "Unspecified", "Dark Cat Synthesizer", "Approved x5"]
    let columns = 3, rows = 4
    let inset: CGFloat = 10
    let labelHeight: CGFloat = 20

    override func viewSafeAreaInsetsDidChange() {
        // Граница видимой части. Видно, что улазит под тулбар PageView. Сверху вроде всё как надо
        let view = UIView(frame: makeSafeRect(self.view))
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(view)

        for i in 0..<min(rows * columns, images.count)
        {
            presentImage(i)
        }
    }

    func presentImage(_ idx: Int) {
        let row = idx / columns, column = idx % columns
        let rect = makeSafeRect(view)
        let w = (rect.size.width - inset * CGFloat(columns + 1)) / CGFloat(columns)
        let h = (rect.size.height - inset * CGFloat(rows + 1)) / CGFloat(rows)
        let x = rect.origin.x + (inset + w) * CGFloat(column) + inset
        let y = rect.origin.y + (inset + h) * CGFloat(row) + inset

        // граница ячейки для проверки корректности
        let view = UIView(frame: CGRect(x: x, y: y, width: w, height: h))
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(view)

        let image = UIImage(named: images[idx])
        if let image = image {
            // скейлим чтобы не было серых рамок (для удовольствия на самом деле)
            var imageWidth = w
            var imageHeight = image.size.height / image.size.width * w
            if (imageHeight + labelHeight > h) {
                imageHeight = h - labelHeight
                imageWidth = image.size.width / image.size.height * imageHeight
            }

            let view = UIImageView(frame: CGRect(x: x + (w - imageWidth) / 2, y: y, width: imageWidth, height: imageHeight))
            view.backgroundColor = UIColor.gray
            view.contentMode = .scaleAspectFit
            view.image = image
            self.view.addSubview(view)

            let label = UILabel(frame: CGRect(x: x, y: y + imageHeight, width: w, height: labelHeight))
            label.text = images[idx]
            label.adjustsFontSizeToFitWidth = true
            label.textAlignment = .center
            label.backgroundColor = UIColor.gray
            self.view.addSubview(label)
        }
    }

}
