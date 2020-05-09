//
//  GradientBackgroundView.swift
//  
//  Copyright © 2016-2019 Apple Inc. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }

    override class var layerClass: Swift.AnyClass {
        return CAGradientLayer.self
    }
}
