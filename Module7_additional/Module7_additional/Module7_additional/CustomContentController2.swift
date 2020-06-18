//
//  CustomContentController2.swift
//  Module7_additional
//
//  Created by Sergey Chistov on 16.06.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class CustomContainerController2: UIViewController {

    private var buttonsStackView = UIStackView()
    private var childsStackView = UIStackView()

    private var childs: [UIViewController] = []
    private var placeholder: UIViewController? // use getPlaceholder() only to access

    override func viewSafeAreaInsetsDidChange() {
        setup()
    }

    private let buttonSize: CGFloat = 30

    func setup() {
        view.addSubview(buttonsStackView)
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.alignment = .center
        buttonsStackView.spacing = 0
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(childsStackView)
        childsStackView.axis = .vertical
        childsStackView.distribution = .fillEqually
        childsStackView.alignment = .fill
        childsStackView.spacing = 0
        childsStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonSize),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -buttonSize),
            buttonsStackView.heightAnchor.constraint(equalToConstant: buttonSize),
            childsStackView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor),
            childsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        showChild(getPlaceholder())
    }

    func addChildWithColor(_ color: UIColor) {
        if (childs.count >= 6) {
            return
        }

        let button = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
        button.setImage(UIImage(systemName: "circle.fill"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(CustomContainerController2.onButton(_:)), for: .touchUpInside)
        button.tintColor = UIColor.gray
        button.tag = childs.count
        buttonsStackView.addArrangedSubview(button)

        let vc = UIViewController()
        vc.view.backgroundColor = color
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        childs.append(vc)
    }

    func setPlaceholder(_ vc: UIViewController) {
        placeholder = vc
    }

    private func showChild(_ child: UIViewController) {
        if child != placeholder && placeholder?.parent != nil {
            removePlaceholder()
        }

        addChild(child)
        childsStackView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }

    private func hideChild(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()

        if child != placeholder && childsStackView.arrangedSubviews.count == 0 {
            addPlaceholder()
        }
    }

    @objc
    func onButton(_ sender: UIButton) {
        let disabled = sender.tintColor == UIColor.gray
        sender.tintColor = disabled ? childs[sender.tag].view.backgroundColor : UIColor.gray
        if disabled {
            showChild(childs[sender.tag])
        } else {
            hideChild(childs[sender.tag])
        }
    }

    func addPlaceholder() {
        showChild(getPlaceholder())
    }

    func removePlaceholder() {
        hideChild(getPlaceholder())
    }

    func getPlaceholder() -> UIViewController {
        if placeholder != nil {
            return placeholder!
        }

        placeholder = UIViewController()
        if let placeholder = placeholder {
            placeholder.view.translatesAutoresizingMaskIntoConstraints = false
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            label.textColor = UIColor.lightGray
            label.text = "Nothing to see here"
            placeholder.view.addSubview(label)
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: placeholder.view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: placeholder.view.centerYAnchor)
            ])
        }
        return placeholder!
    }

}
