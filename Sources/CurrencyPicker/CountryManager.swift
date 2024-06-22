//
//  CountryManager.swift
//  CurrencyPicker
//
//  Created by Munashe Chibaya on 22.06.2024.


import Foundation
import UIKit

public final class CountryManager {
    public static let shared = CountryManager()
    public static let memoizedCountries = CountryManager.getAllCountries()
    public var filteredCountries: [Country] = CountryManager.memoizedCountries.map{$0.value}
    private init() {}

    // Default theme is support dark mode
    public var config: Configuration = Config()

    // For localization we use current locale by default but you can change localeIdentifier for specific cases
    public var localeIdentifier: String = NSLocale.current.identifier

    public func setCountries(isoCodes: [String]?){
        if let isoCodes = isoCodes {
            filteredCountries = findCountries(isCodes: isoCodes)
        }
    }
    
    public func findCountries(isCodes: [String])-> [Country]{
        
        return isCodes.map{findCountry(isCode:$0)}
    }
    
    public func findCountry(isCode: String)-> Country{
          return CountryManager.memoizedCountries[isCode]!
    }
    
    public func getCountries() -> [Country]{
        return filteredCountries
    }
    
    public static func getAllCountries() -> [String: Country]  {
        guard let path = Bundle.module.path(forResource: "countries", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return [:] }
        let rawCountries =  (try? JSONDecoder().decode([Country].self, from: data)) ?? []
        
        var memoizedCountries = [String: Country]()
        
        rawCountries.forEach { memoizedCountries[$0.isoCode] = $0}
        
        return memoizedCountries
    }
}
