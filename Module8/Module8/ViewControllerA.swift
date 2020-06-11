//
//  ViewControllerA.swift
//  Module8
//
//  Created by Sergey Chistov on 04.06.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class ViewControllerA: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    let prevButtonTag = 1, nextButtonTag = 2

    let images = ["Jojo young", "Connection", "Berries", "Gnome", "Armstrong", "Unspecified", "Remove Kebab", "Iggy", "Danny", "Dark Cat Synthesizer", "Approved x5"]
    var current = 0

    override func viewDidLoad() {
        presentImage(current)
    }

    @IBAction func onButton(_ sender: UIButton) {
        switch sender.tag {
        case prevButtonTag:
            presentImage(current - 1)
        case nextButtonTag:
            presentImage(current + 1)
        default:
            break
        }
    }

    func presentImage(_ index: Int) {
        current = index < 0 ? images.count - 1 : index >= images.count ? 0 : index
        let image = UIImage(named: images[current])
        imageView.image = image
    }

}

