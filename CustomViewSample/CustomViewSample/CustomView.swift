//
//  CustomView.swift
//  CustomViewSample
//
//  Created by Sergey Chistov on 31.05.2020.
//  Copyright © 2020 Sergey Chistov. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    override init(frame rect: CGRect) {
        super.init(frame: rect)
        debugLog("init")
        setup()
    }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        debugLog("init?")

        if let selectedImage = decoder.decodeObject() as? UIImage {
            self.selectedImage = selectedImage
        }

        setup()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        debugLog("prepareForInterfaceBuilder")
        setup()
    }

    func setup() {
        debugLog("setup")
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        imageView.image = selectedImage
    }

    func loadViewFromNib() -> UIView {
        debugLog("loadViewFromNib start")
        //let bundle = Bundle.main
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName(), bundle: bundle)
        debugLog("loadViewFromNib instantiate")
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        debugLog("loadViewFromNib end")
        return view
    }

    public func nibName() -> String {
        return type(of: self).description().components(separatedBy: ".").last!
    }

    private var selectedImage: UIImage?
    @IBInspectable var image: UIImage? {
        get {
            return selectedImage
        }
        set(image) {
            debugLog("image set")
            selectedImage = image
            imageView.image = image
        }
    }
}
