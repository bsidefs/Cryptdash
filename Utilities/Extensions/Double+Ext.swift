//
//  Double+Ext.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 9/4/21.
//

import Foundation

extension Double {
    func formatUsingCurrencyAbbreviation() -> String {
        // to determine the suffix
        var number = self
        let integer = Int(self)
        
        let suffix: String
        let digitCount = String(integer).count
        
        switch digitCount {
            case 4...6:
                suffix = "k"
            case 7...9:
                suffix = " million"
            case 10...12:
                suffix = " billion"
            default:
                suffix = ""
        }
        
        // to then format the number
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.maximumFractionDigits = 2
        
        switch digitCount {
            case 4,7,10:
                number = number / pow(10.0, Double(digitCount - 1))
            case 5,8,11:
                number = number / pow(10.0, Double(digitCount - 2))
            case 6,9,12:
                number = number / pow(10.0, Double(digitCount - 3))
            default:
                break
        }
        
        var formattedMarketCap = ""
        if let marketCap = formatter.string(from: NSNumber(value: number)) {
            formattedMarketCap = "\(marketCap)\(suffix)"
        }

        return formattedMarketCap
    }
}
