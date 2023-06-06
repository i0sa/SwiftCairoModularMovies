//
//  UIView+Extensions.swift
//  SwiftCairoDesignSystem
//
//  Created by Osama Gamal on 25/03/2023.
//

import Foundation
extension UIView {
    @objc
    func loadNib() {
        if let subview = Bundle.module.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? UIView {
            embedView(subview)
        }
    }

    @objc func embedView(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
            subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
        ])
    }
}
