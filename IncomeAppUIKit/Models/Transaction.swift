//
//  Transaction.swift
//  IncomeAppUIKit
//
//  Created by Nazrin Atayeva on 06.05.25.
//

import Foundation

struct Transaction {
    let id = UUID()
    let title: String
    let amount: Double
    let type: TransactionType
    let date: Date
    
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    var displayAmount: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: amount as NSNumber) ?? "$0.00"
    }
}
