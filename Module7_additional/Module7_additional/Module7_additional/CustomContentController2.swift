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
    private var _placeholder: UIViewController?

    var placeholder: UIViewController {
        set {
            if let placeholder = _placeholder {
                placeholder.willMove(toParent: nil)
                placeholder.view.removeFromSuperview()
                placeholder.removeFromParent()
            }
            _placeholder = newValue
        }

        get {
            if let placeholder = _placeholder {
                return placeholder
            }

            _placeholder = UIViewController()
            if let placeholder = _placeholder {
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

            return _placeholder!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private let buttonSize: CGFloat = 30

    private func setup() {
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
            buttonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonSize),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -buttonSize),
            buttonsStackView.heightAnchor.constraint(equalToConstant: buttonSize),
            childsStackView.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor),
            childsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        showChild(placeholder, 0)
    }

    func addChildController(_ vc: UIViewController) {
        precondition({childs.count < 6}(), "Too much controllers added, must not exceed 6")
        //guard childs.count < 6 else { return }

        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        let normalImage = UIImage(systemName: "circle.fill")?.withTintColor(.gray).withRenderingMode(.alwaysOriginal)
        button.setBackgroundImage(normalImage, for: .normal)
        let selectedImage = UIImage(systemName: "circle.fill")?.withTintColor(vc.view.backgroundColor ?? UIColor.gray).withRenderingMode(.alwaysOriginal)
        button.setBackgroundImage(selectedImage, for: .selected)
        button.addTarget(self, action: #selector(onButton(_:)), for: .touchUpInside)
        button.tag = childs.count
        buttonsStackView.addArrangedSubview(button)

        childs.append(vc)
    }

    private func showChild(_ child: UIViewController, _ index: Int) {
        if child != placeholder && placeholder.parent != nil {
            removePlaceholder()
        }

        addChild(child)
        childsStackView.insertArrangedSubview(child.view, at: getProperIndex(index))
        child.didMove(toParent: self)
    }

    func getProperIndex(_ index: Int) -> Int {
        var properIndex = 0, currentIndex = 0
        for view in buttonsStackView.subviews {
            guard let button = view as? UIButton else { continue }
            if button.isSelected {
                if button.tag >= index {
                    properIndex = currentIndex
                    break
                } else {
                    currentIndex += 1
                }
            }
        }

        return properIndex
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
    private func onButton(_ sender: UIButton) {
        let index = (buttonsStackView.subviews as? [UIButton])?.firstIndex(of: sender) ?? 0
        sender.isSelected.toggle()
        sender.isSelected ? showChild(childs[index], index) : hideChild(childs[index])
    }

    private func addPlaceholder() {
        showChild(placeholder, 0)
    }

    private func removePlaceholder() {
        hideChild(placeholder)
    }

}
