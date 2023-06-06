//
//  ListItemView.swift
//  SwiftCairoDesignSystem
//
//  Created by Osama Gamal on 25/03/2023.
//

import Foundation
import UIKit

public final class ShimmeringView: UIView {
    
    private var gradientLayer: CAGradientLayer!
    private var backgroundLayer: CALayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        createShimmeringEffect()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createShimmeringEffect()
    }
    
    private func createShimmeringEffect() {
        backgroundLayer = CALayer()
        backgroundLayer.backgroundColor = UIColor.darkGray.cgColor
        layer.addSublayer(backgroundLayer)

        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.white.cgColor,
                                UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = CGRect(x: -bounds.size.width,
                                     y: 0,
                                     width: bounds.size.width * 2,
                                     height: bounds.size.height)
        layer.mask = gradientLayer
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 1.5
        animation.fromValue = -bounds.size.width
        animation.toValue = bounds.size.width
        animation.repeatCount = .infinity
        animation.autoreverses = true
        gradientLayer.add(animation, forKey: "shimmering")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = bounds

        gradientLayer.frame = CGRect(x: -bounds.size.width,
                                     y: 0,
                                     width: bounds.size.width * 2,
                                     height: bounds.size.height)
    }
}
