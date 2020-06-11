//
//  UIView+Constraints.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-09.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat? = nil,
                paddingLeft: CGFloat? = nil,
                paddingBottom: CGFloat? = nil,
                paddingRight: CGFloat? = nil,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {

        let insets = self.safeAreaInsets
        let topInset = insets.top
        let bottomInset = insets.bottom

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop ?? 0 + topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft ?? 0).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -(paddingRight ?? 0)).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -(paddingBottom ?? 0) - bottomInset).isActive = true
        }

        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }

    }

    func embed(in view: UIView,
               paddingTop: CGFloat? = nil,
               paddingLeft: CGFloat? = nil,
               paddingBottom: CGFloat? = nil,
               paddingRight: CGFloat? = nil) {
        anchor(top: view.safeAreaLayoutGuide.topAnchor,
               left: view.leftAnchor,
               bottom: view.bottomAnchor,
               right: view.rightAnchor,
               paddingTop: paddingTop,
               paddingLeft: paddingLeft,
               paddingBottom: paddingBottom,
               paddingRight: paddingRight)
    }

    func center(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
