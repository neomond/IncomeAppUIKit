//
//  AppColors.swift
//  IncomeAppUIKit
//
//  Created by Nazrin Atayeva on 06.05.25.
//

import UIKit

struct AppColors {
    static let primaryLightGreen = UIColor(named: "primaryLightGreen") ?? fallbackGreen
    static let lightGrayShade = UIColor(named: "lightGrayShade") ?? fallbackGray
    
    // Fallbacks in case the named colors aren't found
    private static let fallbackGreen = UIColor(named: "#10AC84")
    private static let fallbackGray = UIColor(named: "#D8D8D8")
}
