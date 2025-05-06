//
//  TransactionType.swift
//  IncomeAppUIKit
//
//  Created by Nazrin Atayeva on 06.05.25.
//

import Foundation

enum TransactionType: String, CaseIterable {
    case income, expense
    
    var title: String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
