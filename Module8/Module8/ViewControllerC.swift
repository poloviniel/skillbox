//
//  ViewControllerC.swift
//  Module8
//
//  Created by Sergey Chistov on 04.06.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

class ViewControllerC: UIViewController {
    private let segmentedControl: UISegmentedControl
    private let containerView: UIView
    private var childsCache: [Int: UIViewController] = [:]

    required init?(coder decoder: NSCoder) {
        //segmentedControl = UISegmentedControl()
        segmentedControl = UISegmentedControl.init(items: [UIImage(systemName: "1.circle.fill") as Any, UIImage(systemName: "2.circle.fill") as Any, UIImage(systemName: "3.circle.fill") as Any])
        containerView = UIView()

        super.init(coder: decoder)
    }

    override func viewDidLoad() {
        view.addSubview(segmentedControl)
        view.addSubview(containerView)
    }

    override func viewSafeAreaInsetsDidChange() {
        setupSegmentedControl()
    }

    func setupSegmentedControl() {
        var rect = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: 20)
        segmentedControl.frame = rect
        segmentedControl.addTarget(self, action: #selector(self.onSegmentedControlValueChanged(_:)), for: .valueChanged)
        rect.origin.y += segmentedControl.frame.height
        rect.size.height = view.bounds.height - rect.origin.y
        containerView.frame = rect
        containerView.backgroundColor = UIColor.gray

        segmentedControl.selectedSegmentIndex = 0
        onSegmentedControlValueChanged(segmentedControl)
    }

    @objc func onSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        let _ = containerView.subviews.map { $0.removeFromSuperview() }
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            add1stView(containerView)
        case 1:
            add2ndView(containerView)
        case 2:
            add3rdView(containerView)
        default:
            break
        }
    }

    func add1stView(_ parent: UIView) {
        let view = UIView(frame: parent.bounds)
        view.backgroundColor = UIColor.green
        parent.addSubview(view)

        var rect = view.bounds
        rect.origin.x += 50
        rect.size.width -= 100
        rect.origin.y = 50
        rect.size.height = 20

        let textField1 = UITextField(frame: rect)
        textField1.borderStyle = .roundedRect
        textField1.text = "Lorem ipsum dolor sit amet"
        view.addSubview(textField1)

        rect.origin.y += 100
        let textField2 = UITextField(frame: rect)
        textField2.borderStyle = .roundedRect
        textField2.text = "Lorem ipsum dolor sit amet"
        view.addSubview(textField2)
    }

    func add2ndView(_ parent: UIView) {
        let view = UIView(frame: parent.bounds)
        view.backgroundColor = UIColor.blue
        parent.addSubview(view)

        var rect = CGRect(x: 100, y: 50, width: view.bounds.size.width - 200, height: 30)
        let button1 = UIButton(frame: rect)
        button1.setTitle("Button 1", for: .normal)
        button1.setTitleColor(UIColor.yellow, for: .normal)
        button1.backgroundColor = UIColor.purple
        view.addSubview(button1)

        rect.origin.y = 100
        let button2 = UIButton(frame: rect)
        button2.setTitle("Button 2", for: .normal)
        button2.setTitleColor(UIColor.red, for: .normal)
        button2.backgroundColor = UIColor.purple
        view.addSubview(button2)

    }

    func add3rdView(_ parent: UIView) {
        let view = UIView(frame: parent.bounds)
        view.backgroundColor = UIColor.purple
        parent.addSubview(view)

        let image1 = UIImageView(frame: CGRect(x: 50, y: 100, width: 100, height: 100))
        image1.image = UIImage(systemName: "trash")
        image1.contentMode = .scaleAspectFit
        view.addSubview(image1)

        let image2 = UIImageView(frame: CGRect(x: 210, y: 100, width: 100, height: 100))
        image2.image = UIImage(systemName: "person.3")
        image2.contentMode = .scaleAspectFit
        view.addSubview(image2)
    }
}
