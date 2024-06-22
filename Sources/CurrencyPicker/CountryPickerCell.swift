//
//  CountryPickerCell.swift
//  CountryPicker
//
//  Created by Munashe Chibaya on 22.06.2024.



import UIKit

public final class CountryPickerCell: UITableViewCell {
    static let reuseIdentifier = "countryCell"

    lazy var countryNameLabel: UILabel = {
        let label = UILabel()
        label.font = CountryManager.shared.config.countryNameTextFont
        label.numberOfLines = 0
        label.textColor = CountryManager.shared.config.countryNameTextColor
        return label
    }()

    lazy var countryCodeLabel: UILabel = {
        let label = UILabel()
        label.font = CountryManager.shared.config.countryCodeFont
        label.textColor = CountryManager.shared.config.countryCodeTextColor
        label.textAlignment = .right
        return label
    }()

    lazy var countryCodeContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = CountryManager.shared.config.selectedCountryCodeCornerRadius
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
            countryNameLabel,
            countryCodeContainerView
        )
        countryCodeContainerView.addSubview(countryCodeLabel)
    }

    func setupLayouts() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        countryCodeContainerView.translatesAutoresizingMaskIntoConstraints = false
        countryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        countryCodeLabel.translatesAutoresizingMaskIntoConstraints = false

        countryCodeLabel.setContentHuggingPriority(.required, for: .horizontal)
        countryCodeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        countryCodeLabel.leadingAnchor.constraint(equalTo: countryCodeContainerView.leadingAnchor, constant: 6)
            .isActive = true
        countryCodeLabel.trailingAnchor.constraint(equalTo: countryCodeContainerView.trailingAnchor, constant: -8)
            .isActive = true
        countryCodeLabel.topAnchor.constraint(equalTo: countryCodeContainerView.topAnchor, constant: 3).isActive = true
        countryCodeLabel.bottomAnchor.constraint(equalTo: countryCodeContainerView.bottomAnchor, constant: -3)
            .isActive = true

        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
    }

    func set(country: Country, selectedCountry: String) {
        accessibilityIdentifier = country.isoCode
        
        let currencyCode = country.isoCode == "ZW" ? "ZIG" : country.currencyCode
        let currencySymbol = country.isoCode == "ZW" ? "ZIG" : country.currencySymbol
        
        
        countryNameLabel.text = country.isoCode.getFlag() + " " + currencyCode!
        countryCodeLabel.text = "+" + currencySymbol!

        if selectedCountry == country.isoCode {
            countryCodeContainerView.backgroundColor = CountryManager.shared.config.selectedCountryCodeBackgroundColor
            countryCodeLabel.textColor = CountryManager.shared.config.selectedCountryCodeTextColor
        } else {
            countryCodeContainerView.backgroundColor = .clear
            countryCodeLabel.textColor = CountryManager.shared.config.countryCodeTextColor
        }
    }
}
