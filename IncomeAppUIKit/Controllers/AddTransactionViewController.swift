//
//  AddTransactionViewController.swift
//  IncomeAppUIKit
//
//  Created by Nazrin Atayeva on 06.05.25.
//

import UIKit
import SnapKit

class AddTransactionViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: AddTransactionDelegate?
    
    private var amount: Double = 0.0
    private var transactionTitle: String = ""
    private var selectedTransactionType: TransactionType = .expense
    
    // MARK: - UI Elements
    private lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 60, weight: .thin)
        textField.textAlignment = .center
        textField.keyboardType = .decimalPad
        textField.placeholder = "0.00"
        textField.delegate = self
        return textField
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    private lazy var typeSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: TransactionType.allCases.map { $0.title })
        control.selectedSegmentIndex = 1 // Default to Expense
        return control
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = AppColors.primaryLightGreen
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(createTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        amountTextField.becomeFirstResponder()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(amountTextField)
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(0.5)
        }
        
        view.addSubview(typeSegmentedControl)
        typeSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(separatorLine.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        view.addSubview(titleTextField)
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(typeSegmentedControl.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(30)
        }
        
        view.addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
    }
    
    private func setupNavigationBar() {
        title = "Add Transaction"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelTapped)
        )
    }
    
    // MARK: - Actions
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func createTapped() {
        // Validate title
        guard let title = titleTextField.text, title.count >= 2 else {
            showAlert(title: "Invalid title", message: "Title must be at least 2 characters long")
            return
        }
        
        // Parse amount
        guard let amountText = amountTextField.text,
              let amountValue = Double(amountText.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ",", with: "")) else {
            showAlert(title: "Invalid amount", message: "Please enter a valid amount")
            return
        }
        
        // Get selected transaction type
        let transactionType: TransactionType = typeSegmentedControl.selectedSegmentIndex == 0 ? .income : .expense
        
        // Create transaction
        let transaction = Transaction(
            title: title,
            amount: amountValue,
            type: transactionType,
            date: Date()
        )
        
        delegate?.didAddTransaction(transaction)
        dismiss(animated: true)
    }
    
    // MARK: - Helper Methods
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension AddTransactionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amountTextField {

            let allowedCharacters = CharacterSet(charactersIn: "0123456789.")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
