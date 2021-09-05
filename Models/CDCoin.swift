//
//  CDCoin.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/21/21.
//

import SwiftUI
import Combine

struct CDCoin: Decodable, Identifiable {
    // MARK: - Stored Properties
    let id          : String
    
    let name        : String
    let symbol      : String
    let rank        : Int
    
    let price       : String
    let marketCap   : String
    let change      : String
    
    let sparkline   : [String]
    
    let iconUrl     : String
    let color       : String?
    
    // MARK: - Computed Properties
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        
        guard let price = Double(self.price), let formattedPrice = formatter.string(from: NSNumber(value: price)) else {
            return self.price
        }
        
        return formattedPrice
    }
    
    var formattedMarketCap: String {
        return Double(marketCap)!.formatUsingCurrencyAbbreviation()
    }
    
    var formattedChange: String {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        
        formatter.usesSignificantDigits = true
        formatter.minimumSignificantDigits = 2
        formatter.maximumSignificantDigits = 2
        
        formatter.positivePrefix = "+"
        formatter.negativePrefix = "-"
        
        guard let change = Double(self.change), let formattedChange = formatter.string(from: NSNumber(value: change)) else {
            return self.change
        }
        
        return "\(formattedChange)%"
    }
    
    var percentChangeColor: Color {
        if self.change.hasPrefix("-") { return .red }
        else { return .green }
    }
}


// MARK: - Coding Keys
extension CDCoin {
    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        
        case name
        case symbol
        case rank
        
        case price
        case marketCap
        case change
        
        case sparkline
        
        case iconUrl
        case color
    }
}
