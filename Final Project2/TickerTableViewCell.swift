//
//  TickerTableViewCell.swift
//  Final Project
//
//  Created by Brian Leffew on 12/3/17.
//  Copyright © 2017 Brian Leffew. All rights reserved.
//

import UIKit

protocol TickerTableViewCellDelegate: class {
    
}

class TickerTableViewCell: UITableViewCell {
    
    let padding: CGFloat = 10
    static let height: CGFloat = 60
    
    var titleLabel: UILabel!
    var priceLabel: UILabel!
    
    weak var delegate: TickerTableViewCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        titleLabel = UILabel(frame: CGRect(x: padding, y: padding, width: 100, height: 20))
        priceLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - padding - 75, y: padding, width: 100, height: 20))
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(priceLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("oopsie")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupWithTicker(ticker: Ticker) {
        titleLabel.text = ticker.name
        priceLabel.text = "$" + String(ticker.currentPrice)
    }
    
}

