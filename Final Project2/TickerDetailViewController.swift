//
//  TickerDetailViewController.swift
//  Final Project
//
//  Created by Brian Leffew on 12/4/17.
//  Copyright © 2017 Brian Leffew. All rights reserved.
//

import UIKit
import Charts

class TickerDetailViewController: UIViewController {
    
    var ticker: Ticker!
    var tickerLabel: UILabel!
    var nameLabel: UILabel!
    var priceLabel: UILabel!
    // chart
    var chartView: LineChartView!
    var chartLabel: UILabel!
    
    
    init(ticker: Ticker) {
        self.ticker = ticker
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("oopsie")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 30))
        nameLabel.text = ticker.fullName
        nameLabel.font = nameLabel.font.withSize(50)
        nameLabel.sizeToFit()
        nameLabel.center.x = self.view.center.x
        
        tickerLabel = UILabel(frame: CGRect(x: 0, y: 200, width: 100, height: 30))
        tickerLabel.text = ticker.name
        tickerLabel.sizeToFit()
        tickerLabel.center.x = view.center.x
        
        priceLabel = UILabel(frame: CGRect(x: 0, y: 250, width: 100, height: 30))
        priceLabel.text = "Current Price: $" + String(ticker.currentPrice)
        priceLabel.sizeToFit()
        priceLabel.center.x = view.center.x
        
        chartLabel = UILabel(frame: CGRect(x: 0, y: view.frame.height - 35, width: 100, height: 30))
        chartLabel.text = "Price history over past week"
        chartLabel.sizeToFit()
        chartLabel.center.x = view.center.x
        
        // setup chart
        setupChart()
        
        
        view.addSubview(tickerLabel)
        view.addSubview(priceLabel)
        view.addSubview(nameLabel)
        view.addSubview(chartLabel)
    }
    
    func setupChart() -> Void {
        chartView = LineChartView(frame: CGRect(x: 0, y: 300, width: view.frame.width, height: 325))
        // set labels
        let currentPrice = ticker.currentPrice
        let weekOldPrice = ticker.currentPrice / (1 + ticker.percentChange7d / 100)
        let lineChartEntry: [ChartDataEntry] = [ChartDataEntry(x: 0, y: weekOldPrice), ChartDataEntry(x: 7, y: currentPrice)]
        
        let line = LineChartDataSet(values: lineChartEntry, label: "Price")
        
        line.colors = [NSUIColor.blue] // set color to blue
        
        let data = LineChartData()
        data.addDataSet(line)
        chartView.data = data
        chartView.chartDescription?.text = "Price history"
        
        view.addSubview(chartView)
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

