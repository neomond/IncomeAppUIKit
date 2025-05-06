//
//  HomeViewController.swift
//  IncomeAppUIKit
//
//  Created by Nazrin Atayeva on 06.05.25.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private var transactions: [Transaction] = [
        Transaction(
            title: "Apple",
            amount: 5.00,
            type: .expense,
            date: Date()),
        Transaction(
            title: "Salary",
            amount: 1000.00,
            type: .income,
            date: Date())
    ]
    
    // MARK: - UI Elements
    private lazy var balanceView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.primaryLightGreen
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        return view
    }()
    
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransactionCell.self, forCellReuseIdentifier: TransactionCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.backgroundColor = AppColors.primaryLightGreen
        button.layer.cornerRadius = 35
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        updateBalanceInfo()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        setupBalanceView()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(balanceView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(70)
        }
    }
    
    private func setupBalanceView() {
        view.addSubview(balanceView)
        balanceView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(170)
        }
        
        balanceView.addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        balanceView.addSubview(balanceAmountLabel)
        balanceAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        balanceView.addSubview(expenseLabel)
        expenseLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(balanceAmountLabel.snp.bottom).offset(26)
        }
        
        balanceView.addSubview(expenseAmountLabel)
        expenseAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(expenseLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        balanceView.addSubview(incomeLabel)
        incomeLabel.snp.makeConstraints { make in
            make.leading.equalTo(expenseLabel.snp.trailing).offset(30)
            make.top.equalTo(balanceAmountLabel.snp.bottom).offset(26)
        }
        
        balanceView.addSubview(incomeAmountLabel)
        incomeAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(incomeLabel.snp.bottom).offset(4)
            make.leading.equalTo(expenseLabel.snp.trailing).offset(25)
        }
    }
    
    private func setupNavigationBar() {
        title = "Income"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let settingsButton = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            style: .plain,
            target: self,
            action: #selector(settingsTapped)
        )
        settingsButton.tintColor = .black
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    // MARK: - Actions
    @objc private func settingsTapped() {
        print("Settings tapped")
    }
    
    @objc private func addButtonTapped() {
        let addVC = AddTransactionViewController()
        addVC.delegate = self
        let navController = UINavigationController(rootViewController: addVC)
        present(navController, animated: true)
    }
    
    // MARK: - Helper Methods
    private func updateBalanceInfo() {
        let totalIncome = transactions.filter { $0.type == .income }.reduce(0) { $0 + $1.amount }
        let totalExpense = transactions.filter { $0.type == .expense }.reduce(0) { $0 + $1.amount }
        let balance = totalIncome - totalExpense
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        
        balanceAmountLabel.text = numberFormatter.string(from: NSNumber(value: balance))
        incomeAmountLabel.text = numberFormatter.string(from: NSNumber(value: totalIncome))
        expenseAmountLabel.text = numberFormatter.string(from: NSNumber(value: totalExpense))
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.identifier, for: indexPath) as? TransactionCell else {
            return UITableViewCell()
        }
        
        let transaction = transactions[indexPath.row]
        cell.configure(with: transaction)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

// MARK: - AddTransactionDelegate
extension HomeViewController: AddTransactionDelegate {
    func didAddTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        tableView.reloadData()
        updateBalanceInfo()
    }
}


