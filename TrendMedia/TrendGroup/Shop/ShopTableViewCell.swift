//
//  ShopTableViewCell.swift
//  TrendMedia
//
//  Created by J on 2022/07/19.
//

import UIKit

class ShopTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var shopListLabel: UILabel!
    @IBOutlet weak var shoplistBackground: UIView!
    
    func cellStyle() {
        shoplistBackground.backgroundColor = UIColor(named: "ShopColor")
        shoplistBackground.layer.masksToBounds = true
        shoplistBackground.layer.cornerRadius = 10
        
        checkBoxButton.setTitle("", for: .normal)
        checkBoxButton.tintColor = .black
        
        favoriteButton.setTitle("", for: .normal)
        favoriteButton.tintColor = .black

    }
}
