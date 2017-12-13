//
//  Ticker.swift
//  Final Project
//
//  Created by Brian Leffew on 12/3/17.
//  Copyright © 2017 Brian Leffew. All rights reserved.
//

import Foundation
import SwiftyJSON

class Ticker {
    var name: String // three letter abreviation of ticker eg BTC
    var fullName: String // full name of ticker eg bitcoin
    var currentPrice: Double // current price of coin in usd
    // used in calculating graph:

    var percentChange7d: Double
    
    init(json: JSON) {
        name = json["symbol"].stringValue
        fullName = json["name"].stringValue
        // round price to two decimal places
        currentPrice = round(100 * json["price_usd"].doubleValue)/100
        percentChange7d = json["percent_change_7d"].doubleValue
    }

}

