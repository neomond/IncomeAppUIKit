//
//  FloatingAddButton.swift
//  IncomeAppUIKit
//
//  Created by Nazrin Atayeva on 06.05.25.
//

import UIKit
import SnapKit

class FloatingAddButton: UIButton {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupButton() {
        setTitle("+", for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 30)
        backgroundColor = AppColors.primaryLightGreen
        layer.cornerRadius = 35
        applyShadow()
    }
}
