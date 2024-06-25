//
//  CurrencyPickerCell.swift
//  CurrencyPicker
//
//  Created by Munashe Chibaya on 22.06.2024.



import UIKit

public final class CurrencyPickerCell: UITableViewCell {
    static let reuseIdentifier = "currencyCell"

    lazy var currencyNameLabel: UILabel = {
        let label = UILabel()
        label.font = CurrencyManager.shared.config.currencyNameTextFont
        label.numberOfLines = 0
        label.textColor = CurrencyManager.shared.config.currencyNameTextColor
        return label
    }()

    lazy var currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.font = CurrencyManager.shared.config.currencyCodeFont
        label.textColor = CurrencyManager.shared.config.currencyCodeTextColor
        label.textAlignment = .right
        return label
    }()

    lazy var currencyCodeContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = CurrencyManager.shared.config.selectedCurrencyCodeCornerRadius
        return view
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        setupViews()
        setupLayouts()
    }

    func setupViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubviews(
            currencyNameLabel,
            currencyCodeContainerView
        )
        currencyCodeContainerView.addSubview(currencyCodeLabel)
    }

    func setupLayouts() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        currencyCodeContainerView.translatesAutoresizingMaskIntoConstraints = false
        currencyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        currencyCodeLabel.translatesAutoresizingMaskIntoConstraints = false

        currencyCodeLabel.setContentHuggingPriority(.required, for: .horizontal)
        currencyCodeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        currencyCodeLabel.leadingAnchor.constraint(equalTo: currencyCodeContainerView.leadingAnchor, constant: 6)
            .isActive = true
        currencyCodeLabel.trailingAnchor.constraint(equalTo: currencyCodeContainerView.trailingAnchor, constant: -8)
            .isActive = true
        currencyCodeLabel.topAnchor.constraint(equalTo: currencyCodeContainerView.topAnchor, constant: 3).isActive = true
        currencyCodeLabel.bottomAnchor.constraint(equalTo: currencyCodeContainerView.bottomAnchor, constant: -3)
            .isActive = true

        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
    }

    func set(currency: Currency, selectedCurrency: String) {
        accessibilityIdentifier = currency.isoCode
        
        let currencyCode = currency.isoCode == "ZW" ? "ZIG" : currency.currencyCode
        let currencySymbol = currency.isoCode == "ZW" ? "ZIG" : currency.currencySymbol
        
        
        currencyNameLabel.text = currency.isoCode.getFlag() + " " + currencyCode!
        currencyCodeLabel.text = "+" + currencySymbol!

        if selectedCurrency == currency.isoCode {
            currencyCodeContainerView.backgroundColor = CurrencyManager.shared.config.selectedCurrencyCodeBackgroundColor
            currencyCodeLabel.textColor = CurrencyManager.shared.config.selectedCurrencyCodeTextColor
        } else {
            currencyCodeContainerView.backgroundColor = .clear
            currencyCodeLabel.textColor = CurrencyManager.shared.config.currencyCodeTextColor
        }
    }
}
