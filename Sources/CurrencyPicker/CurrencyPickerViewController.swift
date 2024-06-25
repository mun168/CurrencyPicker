//
//  CurrencyPicker.swift
//  CurrencyPicker
//
//  Created by Samet MACİT on 29.12.2020.
//  Copyright © 2021 Mobven. All rights reserved.
//

import UIKit

public protocol CurrencyPickerDelegate: AnyObject {
    func currencyPicker(didSelect currency: Currency)
}

public final class CurrencyPickerViewController: UIViewController {
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorCompatibility.systemBackground
        return view
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = CurrencyManager.shared.config.titleText
        label.font = CurrencyManager.shared.config.titleFont
        label.textColor = CurrencyManager.shared.config.titleTextColor
        return label
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle(CurrencyManager.shared.config.closeButtonText, for: .normal)
        button.setTitleColor(CurrencyManager.shared.config.closeButtonTextColor, for: .normal)
        button.titleLabel?.font = CurrencyManager.shared.config.closeButtonFont
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()

    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = CurrencyManager.shared.config.searchBarCornerRadius
        textField.backgroundColor = CurrencyManager.shared.config.searchBarBackgroundColor
        textField.addTarget(self, action: #selector(textEditingChanged), for: .editingChanged)
        textField.font = CurrencyManager.shared.config.searchBarFont
        textField.attributedPlaceholder = NSAttributedString(
            string: CurrencyManager.shared.config.searchBarPlaceholder,
            attributes: [
                NSAttributedString.Key.foregroundColor:
                    CurrencyManager.shared.config.searchBarPlaceholderColor
            ]
        )
        setSearchIcon(textField)
        setClearButton(textField)
        return textField
    }()

    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = CurrencyManager.shared.config.separatorColor
        return view
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CurrencyPickerCell.self, forCellReuseIdentifier: CurrencyPickerCell.reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()

    /// Add search icon to textfield, default asset is "02Icons16X16Search"
    private func setSearchIcon(_ textField: UITextField) {
        let outerView =
            UIView(frame: CGRect(x: iconPadding, y: 0, width: iconHeight + (iconPadding * 2), height: iconHeight))
        let iconView = UIImageView(frame: CGRect(x: iconPadding, y: 0, width: iconHeight, height: iconHeight))
        iconView.image = CurrencyManager.shared.config.searchBarLeftImage ?? UIImage(
            named: "02Icons16X16Search",
            in: .module,
            compatibleWith: nil
        )
        outerView.addSubview(iconView)
        textField.leftView = outerView
        textField.leftViewMode = .always
    }

    /// Add custom image for clear button, default is textFields clear image.
    private func setClearButton(_ textField: UITextField) {
        if let image = CurrencyManager.shared.config.searchBarClearImage {
            let outerView = UIView(frame: CGRect(x: 0, y: 0, width: iconHeight + iconPadding, height: iconHeight))
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: iconHeight, height: iconHeight))
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(clearText), for: .touchUpInside)
            outerView.addSubview(button)
            textField.rightView = outerView
            textField.rightViewMode = .whileEditing
        } else {
            textField.clearButtonMode = .whileEditing
        }
    }

    public weak var delegate: CurrencyPickerDelegate?

    // MARK: - Constants

    private let iconPadding: CGFloat = 12
    private let iconHeight: CGFloat = 16
    private let estimatedCellHeight: CGFloat = 52

    private var currencies: [Currency] = []
    private var filteredCurrencies: [Currency] = []

    /// selectedCurrency will be shown in the first cell, default is "TR"
    public var selectedCurrency: String = "TR" {
        didSet {
            if let selectedIndex = currencies.firstIndex(where: { $0.isoCode == selectedCurrency }) {
                let currency = currencies[selectedIndex]
                currencies.remove(at: selectedIndex)
                currencies.insert(currency, at: 0)
                filteredCurrencies = currencies
            }
        }
    }

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        currencies = CurrencyManager.shared.getCurrencies()
        filteredCurrencies = currencies
        tableView.reloadData()
    }

    func setup() {
        setupViews()
        setupLayouts()
    }

    func setupViews() {
        headerView.addSubviews(
            titleLabel,
            closeButton,
            searchTextField,
            separatorView
        )
        view.addSubviews(tableView, headerView)
    }

    func setupLayouts() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 132).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 21).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true

        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 23).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -21).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true

        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
    }

    @objc func close() {
        dismiss(animated: true)
    }

    // MARK: - TextField Methods

    @objc func textEditingChanged() {
        if searchTextField.text?.count == 0 {
            filteredCurrencies = currencies
        } else if let text = searchTextField.text {
            filteredCurrencies = currencies
                .filter { $0.localizedName.localizedLowercase.contains(text.localizedLowercase) }
        }
        tableView.reloadData()
    }

    @objc func clearText() {
        searchTextField.text = ""
        textEditingChanged()
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension CurrencyPickerViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCurrencies.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CurrencyPickerCell.reuseIdentifier,
            for: indexPath
        )
            as? CurrencyPickerCell else { return UITableViewCell() }
        let item = filteredCurrencies[indexPath.row]
        cell.set(currency: item, selectedCurrency: selectedCurrency)
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        estimatedCellHeight
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.delegate?.currencyPicker(didSelect: self.filteredCurrencies[indexPath.row])
        }
    }
}
