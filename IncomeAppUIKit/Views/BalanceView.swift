//
//  BalanceView.swift
//  IncomeAppUIKit
//
//  Created by Nazrin Atayeva on 06.05.25.
//

import UIKit
import SnapKit


class BalanceView: UIView {
    
    // MARK: - UI Elements
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "BALANCE"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    private lazy var balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0"
        label.font = UIFont.systemFont(ofSize: 42, weight: .light)
        label.textColor = .white
        return label
    }()
    
    private lazy var expenseLabel: UILabel = {
        let label = UILabel()
        label.text = "Expense"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var expenseAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    private lazy var incomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Income"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var incomeAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = AppColors.primaryLightGreen
        layer.cornerRadius = 8
        applyShadow(radius: 10, offset: CGSize(width: 0, height: 10))

        setupBalanceLabels()
        setupTransactionLabels()
    }
    
    private func setupBalanceLabels() {
        addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        addSubview(balanceAmountLabel)
        balanceAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
    }
    
    private func setupTransactionLabels() {
        addSubview(expenseLabel)
        expenseLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceAmountLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        addSubview(expenseAmountLabel)
        expenseAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(expenseLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        addSubview(incomeLabel)
        incomeLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceAmountLabel.snp.bottom).offset(16)
            make.leading.equalTo(expenseLabel.snp.trailing).offset(25)
        }
        
        addSubview(incomeAmountLabel)
        incomeAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(incomeLabel.snp.bottom).offset(4)
            make.leading.equalTo(expenseLabel.snp.trailing).offset(25)
        }
    }
    
    // MARK: - Public Methods
    func updateBalance(balance: Double, income: Double, expense: Double) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        
        balanceAmountLabel.text = numberFormatter.string(from: NSNumber(value: balance))
        incomeAmountLabel.text = numberFormatter.string(from: NSNumber(value: income))
        expenseAmountLabel.text = numberFormatter.string(from: NSNumber(value: expense))
    }
}
