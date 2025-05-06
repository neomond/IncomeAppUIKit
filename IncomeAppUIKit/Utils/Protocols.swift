//
//  Protocols.swift
//  IncomeAppUIKit
//
//  Created by Nazrin Atayeva on 06.05.25.
//

import Foundation

protocol AddTransactionDelegate: AnyObject {
    func didAddTransaction(_ transaction: Transaction)
}
