//
//  TransactionCell.swift
//  IncomeAppUIKit
//
//  Created by Nazrin Atayeva on 06.05.25.
//

import UIKit
import SnapKit

class TransactionCell: UITableViewCell {
    
    static let identifier = "TransactionCell"
    
    // MARK: - UI Elements
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var dateView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.lightGrayShade
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var transactionDetailsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var typeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Completed"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubviewsToContentView()
        addSubviewsToContainerView()
        addSubviewsToDateView()
        addSubviewsToTransactionDetailsContainer()
    }
    
    private func addSubviewsToContentView() {
        contentView.addSubview(containerView)
    }
    
    private func addSubviewsToContainerView() {
        containerView.addSubview(dateView)
        containerView.addSubview(transactionDetailsContainer)
    }
    
    private func addSubviewsToDateView() {
        dateView.addSubview(dateLabel)
    }
    
    private func addSubviewsToTransactionDetailsContainer() {
        transactionDetailsContainer.addSubview(typeImageView)
        transactionDetailsContainer.addSubview(titleLabel)
        transactionDetailsContainer.addSubview(amountLabel)
        transactionDetailsContainer.addSubview(statusLabel)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        setupContainerViewConstraints()
        setupDateViewConstraints()
        setupTransactionDetailsContainerConstraints()
        setupTransactionDetailsConstraints()
    }
    
    private func setupContainerViewConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(36)
            make.trailing.equalToSuperview().offset(-36)
        }
    }
    
    private func setupDateViewConstraints() {
        dateView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    private func setupTransactionDetailsContainerConstraints() {
        transactionDetailsContainer.snp.makeConstraints { make in
            make.top.equalTo(dateView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTransactionDetailsConstraints() {
        typeImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.bottom.equalTo(statusLabel.snp.top).offset(-5)
            make.leading.equalTo(typeImageView.snp.trailing).offset(8)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(8)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(typeImageView.snp.trailing).offset(8)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Configuration
    func configure(with transaction: Transaction) {
        dateLabel.text = transaction.displayDate
        titleLabel.text = transaction.title
        amountLabel.text = transaction.displayAmount
        
        let imageName = transaction.type == .income ? "arrow.up.forward" : "arrow.down.forward"
        typeImageView.image = UIImage(systemName: imageName)
        typeImageView.tintColor = transaction.type == .income ? .systemGreen : .systemRed
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        titleLabel.text = nil
        amountLabel.text = nil
        typeImageView.image = nil
    }
}
