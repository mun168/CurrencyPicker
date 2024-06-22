//
//  Country.swift
//  CurrencyPicker
//
//  Created by Munashe Chibaya on 22.06.2022.


import Foundation

public struct Country: Codable {
    public var phoneCode: String
    public let isoCode: String

    public init(phoneCode: String, isoCode: String) {
        self.phoneCode = phoneCode
        self.isoCode = isoCode
    }
    
    public init(isoCode: String) {
        self.isoCode = isoCode
        self.phoneCode = ""
        if let country = CountryManager.shared.getCountries().first(where: { $0.isoCode == isoCode }) {
            self.phoneCode = country.phoneCode
        }
    }
}

public extension Country {
    /// Returns localized country name for localeIdentifier
    ///

    var appLocalIdentifier: NSLocale{
        return NSLocale(localeIdentifier: CountryManager.shared.localeIdentifier)
    }
    
    var countryLocaleIdentifier: String
    {
       NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: isoCode])
    }
    
    var countryLocale: NSLocale
    {
        NSLocale(localeIdentifier: countryLocaleIdentifier)
    }
    
    var name: String {
        countryLocale.localizedString(forCountryCode: isoCode ?? "") ?? isoCode
    }
    
    var code: String{
        isoCode
    }
    
    var localizedName: String {
        countryLocale.localizedString(forCountryCode: isoCode ?? "") ?? isoCode
    }
    
    var currencyName: String? {
        countryLocale.localizedString(forCurrencyCode: countryLocale.currencyCode ?? "") ?? "N/A"
    }
    
    var currencyCode: String? {
        countryLocale.currencyCode
    }
    var currencySymbol: String? {
        countryLocale.currencySymbol
    }
}
