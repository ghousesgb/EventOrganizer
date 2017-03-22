//
//  GradientViewX.swift
//  VSoft
//
//  Created by Shaik Ghouse Basha on 18/3/17.
//  Copyright © 2017 Shaik Ghouse Basha. All rights reserved.
//

import UIKit

@IBDesignable
class UIViewX: UIView {

    @IBInspectable var FirstColor : UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var SecondColor : UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    override class var layerClass: Swift.AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    @IBInspectable var CornerRadius : CGFloat = 0 {
        didSet {
            let layer = self.layer
            layer.cornerRadius = CornerRadius
        }
    }
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor, SecondColor.cgColor]
    }
}
