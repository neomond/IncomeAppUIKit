//
//  Protocols.swift
//  IncomeAppUIKit
//
//  Created by Nazrin Atayeva on 06.05.25.
//

import Foundation

protocol AddTransactionDelegate: AnyObject {
    func didAddTransaction(_ transaction: Transaction)
    func didUpdateTransaction(_ transaction: Transaction, at index: Int)
}

protocol TransactionDismissDelegate: AnyObject {
    func didDismissTransaction()
}

protocol TransactionSelectionDelegate: AnyObject {
    func didSelectTransaction(_ transaction: Transaction, at index: Int)
    func didDeleteTransaction(at index: Int)
}
