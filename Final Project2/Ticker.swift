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
    var fullName: String // full name of ticker egn bitcoin
    var currentPrice: Double // current price of coin in usd
    // Todo graph
    
    init(json: JSON) {
        let meta = json["Meta Data"].dictionary!
        name = meta["2. Digital Currency Code"]!.stringValue
        fullName = meta["3. Digital Currency Name"]!.stringValue
        
        // get most recently updated datetime
        let lastRefreshed = meta["7. Last Refreshed"]!.stringValue
        
        currentPrice = json["Time Series (Digital Currency Intraday)"].dictionary![lastRefreshed]!.dictionary!["1a. price (USD)"]!.doubleValue
        
    }
    
    init(name: String, fullName: String, currentPrice: Double) {
        self.name = name
        self.fullName = fullName
        self.currentPrice = currentPrice
    }
}

