//
//  View+Shadow.swift
//  IncomeAppUIKit
//
//  Created by Nazrin Atayeva on 06.05.25.
//

import UIKit

extension UIView {
    func applyShadow(
        color: UIColor = .black,
        opacity: Float = 0.3,
        radius: CGFloat = 5,
        offset: CGSize = CGSize(width: 0, height: 3)
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
}
