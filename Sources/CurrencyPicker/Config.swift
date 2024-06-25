//
//  Configuration.swift
//  CurrencyPicker
//
//  Created by Munashe Chibaya on 22.06.2024.
//
/*
    Theme configuration for CurrencyPicker. Default config is support dark mode
 */

import Foundation
import UIKit

public protocol Configuration {
    var currencyNameTextColor: UIColor { get set }
    var currencyNameTextFont: UIFont { get set }
    var selectedCurrencyCodeBackgroundColor: UIColor { get set }
    var selectedCurrencyCodeTextColor: UIColor { get set }
    var selectedCurrencyCodeCornerRadius: CGFloat { get set }
    var currencyCodeFont: UIFont { get set }
    var currencyCodeTextColor: UIColor { get set }
    var closeButtonTextColor: UIColor { get set }
    var closeButtonFont: UIFont { get set }
    var closeButtonText: String { get set }
    var titleTextColor: UIColor { get set }
    var titleFont: UIFont { get set }
    var titleText: String { get set }
    var searchBarPlaceholder: String { get set }
    var searchBarBackgroundColor: UIColor { get set }
    var searchBarPlaceholderColor: UIColor { get set }
    var searchBarFont: UIFont { get set }
    var searchBarLeftImage: UIImage? { get set }
    var searchBarClearImage: UIImage? { get set }
    var searchBarCornerRadius: CGFloat { get set }
    var separatorColor: UIColor { get set }
}

public struct Config: Configuration {
    
    /// textColor of currencyNameLabel
    public var currencyNameTextColor: UIColor
    
    /// font of currencyNameLabel
    public var currencyNameTextFont: UIFont
    
    /// background color of currencyCodeLabel's selected state
    public var selectedCurrencyCodeBackgroundColor: UIColor
    
    /// textColor of currencyCodeLabel's selected state
    public var selectedCurrencyCodeTextColor: UIColor
    
    /// corner radius of currencyCodeLabel's selected state
    public var selectedCurrencyCodeCornerRadius: CGFloat
    
    /// font of currencyCodeLabel
    public var currencyCodeFont: UIFont
    
    /// textColor of currencyCodeLabel
    public var currencyCodeTextColor: UIColor
    
    /// textColor of closeButton
    public var closeButtonTextColor: UIColor
    
    /// font of closeButton
    public var closeButtonFont: UIFont
    
    // text of closeButton
    public var closeButtonText: String
    
    /// textColor of titleLabel
    public var titleTextColor: UIColor
    
    /// font of titleLabel
    public var titleFont: UIFont

    /// text of titleLabel
    public var titleText: String

    /// placeholder text of searchTextField
    public var searchBarPlaceholder: String
    
    /// background color  of searchTextField
    public var searchBarBackgroundColor: UIColor
    
    /// placeholder text color of searchTextField
    public var searchBarPlaceholderColor: UIColor
    
    /// font of searchTextField
    public var searchBarFont: UIFont
    
    /// left image of searchTextField
    public var searchBarLeftImage: UIImage?
    
    /// clear image of searchTextField
    public var searchBarClearImage: UIImage?
    
    /// corner radius of searchTextField
    public var searchBarCornerRadius: CGFloat
    
    /// background color of separatorView
    public var separatorColor: UIColor

    public init(
        currencyNameTextColor: UIColor = ColorCompatibility.label,
        currencyNameTextFont: UIFont = UIFont.systemFont(ofSize: 16),
        selectedCurrencyCodeBackgroundColor: UIColor = .systemGreen,
        selectedCurrencyCodeTextColor: UIColor = ColorCompatibility.systemBackground,
        selectedCurrencyCodeCornerRadius: CGFloat = 8,
        currencyCodeFont: UIFont = UIFont.systemFont(ofSize: 16),
        currencyCodeTextColor: UIColor = ColorCompatibility.systemGray2,
        closeButtonTextColor: UIColor = .systemGreen,
        closeButtonFont: UIFont = UIFont.systemFont(ofSize: 16),
        closeButtonText: String = "Close",
        titleTextColor: UIColor = ColorCompatibility.label,
        titleFont: UIFont = UIFont.boldSystemFont(ofSize: 18),
        titleText: String = "Select Currency",
        searchBarPlaceholder: String = "Search...",
        searchBarBackgroundColor: UIColor = ColorCompatibility.systemGray5,
        searchBarPlaceholderColor: UIColor = ColorCompatibility.systemGray2,
        searchBarFont: UIFont = UIFont.systemFont(ofSize: 16),
        searchBarLeftImage: UIImage? = nil,
        searchBarClearImage: UIImage? = nil,
        searchBarCornerRadius: CGFloat = 4,
        separatorColor: UIColor = ColorCompatibility.systemGray5
    ) {
        self.currencyNameTextColor = currencyNameTextColor
        self.currencyNameTextFont = currencyNameTextFont
        self.selectedCurrencyCodeBackgroundColor = selectedCurrencyCodeBackgroundColor
        self.selectedCurrencyCodeTextColor = selectedCurrencyCodeTextColor
        self.currencyCodeFont = currencyCodeFont
        self.currencyCodeTextColor = currencyCodeTextColor
        self.selectedCurrencyCodeCornerRadius = selectedCurrencyCodeCornerRadius
        self.closeButtonTextColor = closeButtonTextColor
        self.closeButtonFont = closeButtonFont
        self.closeButtonText = closeButtonText
        self.titleTextColor = titleTextColor
        self.titleFont = titleFont
        self.titleText = titleText
        self.searchBarPlaceholder = searchBarPlaceholder
        self.searchBarBackgroundColor = searchBarBackgroundColor
        self.searchBarPlaceholderColor = searchBarPlaceholderColor
        self.searchBarFont = searchBarFont
        self.searchBarLeftImage = searchBarLeftImage
        self.searchBarClearImage = searchBarClearImage
        self.searchBarCornerRadius = searchBarCornerRadius
        self.separatorColor = separatorColor
    }
}
