//
//  CDCoinResponseContainer.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/21/21.
//

import Foundation

struct CDCoinResponseContainer: Decodable {
    let status  : String
    let data    : CDCoinData
}

struct CDCoinData: Decodable {
    let coins   : [CDCoin]
}
