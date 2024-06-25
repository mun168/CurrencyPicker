//
//  CurrencyManager.swift
//  CurrencyPicker
//
//  Created by Munashe Chibaya on 22.06.2024.


import Foundation
import UIKit

public final class CurrencyManager {
    public static let shared = CurrencyManager()
    public static let memoizedCurrencies = CurrencyManager.getAllCurrencies()
    public var filteredCurrencies: [Currency] = CurrencyManager.memoizedCurrencies.map{$0.value}
    private init() {}

    // Default theme is support dark mode
    public var config: Configuration = Config()

    // For localization we use current locale by default but you can change localeIdentifier for specific cases
    public var localeIdentifier: String = NSLocale.current.identifier

    public func setCurrencies(isoCodes: [String]?){
    
        
        if let isoCodes = isoCodes {
            filteredCurrencies = findCurrencies(isCodes: isoCodes)
            print("sdf" , filteredCurrencies)
        }
    }
    
    public func findCurrencies(isCodes: [String])-> [Currency]{
        
        return isCodes.map{findCurrency(isCode:$0)}
    }
    
    public func findCurrency(isCode: String)-> Currency{
          print("isCode" , isCode)
          return CurrencyManager.memoizedCurrencies[isCode]!
    }
    
    public func getCurrencies() -> [Currency]{
        return filteredCurrencies
    }
    
    public static func getAllCurrencies() -> [String: Currency]  {
        print("muno")
        guard let path = Bundle.module.path(forResource: "currencies", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return [:] }
        let rawCurrencies =  (try? JSONDecoder().decode([Currency].self, from: data)) ?? []
        print("munomu")
        print("rawCurrencies" , rawCurrencies.count)
        var memoizedCurrencies = [String: Currency]()
        
        rawCurrencies.forEach { memoizedCurrencies[$0.isoCode] = $0}
        
        return memoizedCurrencies
    }
}
