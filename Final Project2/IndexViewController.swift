//
//  IndexViewController.swift
//  Final Project
//
//  Created by Brian Leffew on 11/30/17.
//  Copyright © 2017 Brian Leffew. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var tickerTableView: UITableView!
    var searchController: UISearchController!
    
    var tickers: [Ticker]!
    var filteredTickers = [Ticker]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto Tracker"
        
        tickerTableView = UITableView(frame: view.frame, style: .plain)
        
        tickerTableView.dataSource = self
        tickerTableView.delegate = self
        tickerTableView.register(TickerTableViewCell.self, forCellReuseIdentifier: "TickerTableViewCell")
        tickerTableView.rowHeight = TickerTableViewCell.height
        
        // setup search bar
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        self.tickerTableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        
        // Create pull to refresh view and set it to the collection view's pull to refresh view
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getTickers), for: .valueChanged)
        tickerTableView.refreshControl = refreshControl
        
        
        view.addSubview(tickerTableView)
        getTickers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tickerTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredTickers.count
        }
        
        if let count = tickers?.count {
            return count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TickerTableViewCell", for: indexPath) as? TickerTableViewCell else {return UITableViewCell()}
        let ticker: Ticker
        if isFiltering() {
            ticker = filteredTickers[indexPath.row]
        }
        else {
            ticker = tickers[indexPath.row]
        }
        
        cell.setupWithTicker(ticker: ticker)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ticker: Ticker
        if isFiltering() {
            ticker = filteredTickers[indexPath.row]
        }
        else {
            ticker = tickers[indexPath.row]
        }
        
        let tickerDetailViewController = TickerDetailViewController(ticker: ticker)
        navigationController?.pushViewController(tickerDetailViewController, animated: true)
        self.viewDidLoad()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredTickers = tickers.filter({( ticker : Ticker) -> Bool in
            return ticker.name.lowercased().contains(searchText.lowercased()) || ticker.fullName.lowercased().contains(searchText.lowercased())
        })
        
        tickerTableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    @objc func getTickers() {
        
        // Get posts from network manager
        TickerAPI.getTickers { tickers in
            
            // Get posts from response and unwrap them
            if let tickers = tickers {
                
                // Set them to the view controller's posts property and update the collection view to reflect the new posts
                self.tickers = tickers
                
                // Get on main thread
                // Always update UI on main thread
                DispatchQueue.main.async {
                    
                    // Call our update method
                    self.updateCollectionView()
                }
            }
        }
    }
    
    func updateCollectionView() {
        
        // Reload collection view with fade animation (equivalent to collectionView.reloadData()
        tickerTableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        
        
        // Stop refreshing animation
        tickerTableView.refreshControl?.endRefreshing()
    }
    
}














