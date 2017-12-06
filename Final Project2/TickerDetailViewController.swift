//
//  TickerDetailViewController.swift
//  Final Project
//
//  Created by Brian Leffew on 12/4/17.
//  Copyright © 2017 Brian Leffew. All rights reserved.
//

import UIKit

class TickerDetailViewController: UIViewController {
    
    var ticker: Ticker!
    var tickerLabel: UILabel!
    var priceLabel: UILabel!
    // graph
    
    init(ticker: Ticker) {
        self.ticker = ticker
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("oopsie")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tickerLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        tickerLabel.text = ticker.name
        tickerLabel.font = tickerLabel.font.withSize(50)
        tickerLabel.sizeToFit()
        tickerLabel.center.x = self.view.center.x
        
        priceLabel = UILabel(frame: CGRect(x: 0, y: 200, width: 100, height: 30))
        priceLabel.text = String(ticker.currentPrice)
        priceLabel.sizeToFit()
        priceLabel.center.x = view.center.x
        
        view.addSubview(tickerLabel)
        view.addSubview(priceLabel)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

