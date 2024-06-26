//
//  String+Extensions.swift
//  Currency
//
//  Created by Samet Macit on 31.12.2020
//  Copyright © 2021 Mobven. All rights reserved.

import Foundation

public extension String {
    /// Returns String unicode value of currency flag for iso code
    func getFlag() -> String {
        unicodeScalars
            .map { 127_397 + $0.value }
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}
