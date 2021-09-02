//
//  ListItemTableViewCell.swift
//  KLproject
//
//  Created by KL on 02/09/2021.
//

import UIKit
import SnapKit

final class ListItemTableViewCell: UITableViewCell {
    
    // MARK: - Constants -
    
    private enum Constants {
        static let containerPadding: CGFloat = 20
        static let innerPadding: CGFloat = 8
        static let height: CGFloat = 60
    }
    
    // MARK: - UI Components -
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.cellBackground
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        label.textColor =  AppColor.cellContent
        label.numberOfLines = 2
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor =  AppColor.cellContent
        label.numberOfLines = 1
        return label
    }()
    
    private let verticalSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.cellContent
        return view
    }()
    
    private let dataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor =  AppColor.cellContent
        label.numberOfLines = 1
        return label
    }()
    
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor =  AppColor.cellContent
        label.numberOfLines = 1
        return label
    }()

    private let percentChange1hLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor =  AppColor.cellContent
        label.numberOfLines = 1
        return label
    }()

    private let percentChange24hLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.textColor =  AppColor.cellContent
        label.numberOfLines = 1
        return label
    }()

    // MARK: - Lifecycle -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        defineLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup -
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    // MARK: - Layout -
    
    private func defineLayout() {
        addContainerView()
        addNameLabel()
        addSymbolLabel()
        addVerticalSeparatorView()
        addDataStackView()
    }
    
    private func addContainerView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.left.equalTo(Constants.containerPadding)
            make.right.equalTo(-Constants.containerPadding)
            make.bottom.equalToSuperview()
            make.height.greaterThanOrEqualTo(Constants.height)
        }
    }
    
    private func addNameLabel() {
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalTo(Constants.containerPadding)
        }
    }
    
    private func addSymbolLabel() {
        containerView.addSubview(symbolLabel)
        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.innerPadding)
            make.left.equalTo(Constants.containerPadding)
        }
    }
    
    private func addVerticalSeparatorView() {
        containerView.addSubview(verticalSeparatorView)
        verticalSeparatorView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.containerPadding)
            make.bottom.equalToSuperview().offset(-Constants.containerPadding)
            make.left.greaterThanOrEqualTo(nameLabel.snp.right).offset(Constants.innerPadding)
            make.centerX.equalToSuperview().multipliedBy(0.9)
            make.width.equalTo(0.5)
        }
    }
    
    private func addDataStackView() {
        [priceLabel, volumeLabel, percentChange1hLabel, percentChange24hLabel]
            .forEach { dataStackView.addArrangedSubview($0) }
        containerView.addSubview(dataStackView)
        dataStackView.snp.makeConstraints { make in
            make.top.equalTo(verticalSeparatorView.snp.top).offset(-2)
            make.bottom.equalTo(verticalSeparatorView.snp.bottom).offset(2)
            make.left.equalTo(verticalSeparatorView.snp.right).offset(Constants.containerPadding)
            make.right.equalToSuperview().offset(-Constants.containerPadding)
        }
    }
    
    // MARK: - Public methods -
    
    func configure(withCurrency currency: Cryptocurrency, andPriceChange priceChange: PriceChange) {
        nameLabel.text = currency.name
        symbolLabel.text = currency.symbol
        priceLabel.text = "$\(currency.price)"
        volumeLabel.text = String(currency.volume)
        percentChange1hLabel.text = "\(currency.percentChange1h)%"
        percentChange24hLabel.text = "\(currency.percentChange24h)%"
        
        priceLabel.textColor = priceChange.color
    }
}
