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
import CSV

let hostURL = "https://www.alphavantage.co"
let APIKEY = "RIH8ZP6FEJA5DHHB"

// load data for all tickers from api
class TickerAPI {
    
    static func getTickers(completion: @escaping ([Ticker]?) -> Void) {
        
        // load list of available cyrptos from csv file:
        guard let url = URL(string: hostURL + "/query") else { return }
        
        
        
        let stream = InputStream(fileAtPath: "digital_currency_list-1.csv")!
        
        let csv = try! CSVReader(stream: stream)
        // loop through list of coins
        while let row = csv.next() {
            // get current price:
            let parameters = ["function": "DIGITAL_CURRENCY_INTRADAY", "symbol": row[0], "market": "USD", "apikey": APIKEY]
            Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                .validate()
                .responseJSON { response in
                    
                    switch response.result {
                    case let .success(data):
                        let json = JSON(data)
                        
                        // create ticker array
                        var tickers: [Ticker] = []
                        for tickerJSON in json.arrayValue {
                            tickers.append(Ticker(json: tickerJSON))
                        }
                        
                        // Let caller know we completed the request
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
    
    // return a list of hardcoded tickers
    static func getTickersHardCoded() -> [Ticker] {
        return [Ticker(name: "BTC", fullName: "Bitcoin", currentPrice: 1000),
                Ticker(name: "ETH", fullName: "Ether", currentPrice: 600),
                Ticker(name: "STORJ", fullName: "storjcoin", currentPrice: 1),]
    }
}


