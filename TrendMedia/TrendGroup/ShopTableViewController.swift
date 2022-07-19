//
//  ShopTableViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/19.
//

import UIKit

class ShopTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var searchBackground: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    var shopList: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        shopTextField.delegate = self
        
        //UITextField+Extension
        shopTextField.borderDesign()
        
        searchButtonStyle()
        
        searchBackgroundStyle()
        
    }
    
    // UIView 스타일
    func searchBackgroundStyle() {
        searchBackground.backgroundColor = UIColor(named: "ShopColor")
        searchBackground.layer.masksToBounds = true
        searchBackground.layer.cornerRadius = 20
    }
    
    // 쇼핑 검색 버튼 스타일
    func searchButtonStyle() {
        searchButton.layer.masksToBounds = true
        searchButton.layer.cornerRadius = 5
        searchButton.setTitle("추가", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.setTitleColor(.white, for: .highlighted)
        searchButton.backgroundColor = .lightGray
    }
    
    // textField return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shopTextField.resignFirstResponder()
        shopList.append(shopTextField.text ?? "")
        
        tableView.reloadData()
        shopTextField.text = ""
        return true
    }
    
    // cell의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell", for: indexPath) as? ShopTableViewCell
        
        cell?.checkBoxButton.buttonStyle("checkmark.square", "checkmark.square.fill")
        
        cell?.favoriteButton.buttonStyle("star", "star.fill")
        
        cell?.shopListLabel.text = shopList[indexPath.row]
        
        return cell ?? tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell")!
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shopList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
