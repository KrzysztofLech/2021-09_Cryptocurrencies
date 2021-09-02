//
//  Cryptocurrency.swift
//  KLproject
//
//  Created by KL on 02/09/2021.
//

import Foundation

struct Cryptocurrency: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case percentChange1h = "percent_change_1h"
        case percentChange24h = "percent_change_24h"
        case price = "price_usd"
        case symbol
        case volume = "volume24"
    }
    
    let id: String
    let name: String
    let percentChange1h: String
    let percentChange24h: String
    let price: String
    let symbol: String
    let volume: Double
}
