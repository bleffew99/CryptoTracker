//
//  TickerAPI.swift
//  Final Project
//
//  Created by Brian Leffew on 12/3/17.
//  Copyright © 2017 Brian Leffew. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

let hostURL = "https://api.coinmarketcap.com"

// load data for all tickers from api
class TickerAPI {
    
    // get array of tickers
    static func getTickers(completion: @escaping ([Ticker]?) -> Void) {
        
        // get form url, hardcoded to top 25 cryptocurrencies
        guard let url = URL(string: hostURL + "/v1/ticker/?limit=50") else { return }
        
        // Alamofire request
        Alamofire.request(url, method: .get)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case let .success(data):
                    
                    // Convert json-serialized data to swiftyJSON object
                    let json = JSON(data)
                    
                    // Create Ticker objects from JSON array
                    var tickers: [Ticker] = []
                    for tickerJSON in json.arrayValue {
                        tickers.append(Ticker(json: tickerJSON))
                    }
                    
                    // let caller know we completed request:
                    completion(tickers)
                    
                case .failure(let error):
                    // Something bad happened, print error message. This could've been loss of internet access, web server went down,
                    // our client request was bad, etc. Look up HTTP error codes!
                    // In production apps we would probably display a message to the user that an error occurred.
                    print(error.localizedDescription)
                }
        }
        
    }
    
}


