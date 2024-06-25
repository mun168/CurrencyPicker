//
//  Currency.swift
//  CurrencyPicker
//
//  Created by Munashe Chibaya on 22.06.2022.


import Foundation

public struct Currency: Codable,Equatable {
    public var phoneCode: String
    public let isoCode: String

    public init(phoneCode: String, isoCode: String) {
        self.phoneCode = phoneCode
        self.isoCode = isoCode
    }
    
    public init(isoCode: String) {
        self.isoCode = isoCode
        self.phoneCode = ""
        if let currency = CurrencyManager.shared.getCurrencies().first(where: { $0.isoCode == isoCode }) {
            self.phoneCode = currency.phoneCode
        }
    }
}

public extension Currency {
    /// Returns localized currency name for localeIdentifier
    ///

    var appLocalIdentifier: NSLocale{
        return NSLocale(localeIdentifier: CurrencyManager.shared.localeIdentifier)
    }
    
    var currencyLocaleIdentifier: String
    {
        NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: isoCode])
    }
    
    var currencyLocale: NSLocale
    {
        NSLocale(localeIdentifier: currencyLocaleIdentifier)
    }
    
    var name: String {
        currencyLocale.localizedString(forCurrencyCode: isoCode ?? "") ?? isoCode
    }
    
    var code: String{
        isoCode
    }
    
    var localizedName: String {
        currencyLocale.localizedString(forCurrencyCode: isoCode ?? "") ?? isoCode
    }
    
    var currencyName: String? {
        currencyLocale.localizedString(forCurrencyCode: currencyLocale.currencyCode ?? "") ?? "N/A"
    }
    
    var currencyCode: String? {
        currencyLocale.currencyCode
    }
    var currencySymbol: String? {
        currencyLocale.currencySymbol
    }
}
