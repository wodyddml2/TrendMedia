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
    
    // cell의 Height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // cell의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    // cell 스타일
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell", for: indexPath) as? ShopTableViewCell
        cell?.backgroundColor = UIColor(named: "ShopColor")
        cell?.checkBoxButton.buttonStyle("checkmark.square", "checkmark.square.fill")
        
        cell?.favoriteButton.buttonStyle("star", "star.fill")
        
        cell?.shopListLabel.text = shopList[indexPath.row]
        
        return cell ?? tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell")!
    }

    // 편집 활성화
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 리스트 삭제
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shopList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    // header의 높이를 주어서 위의 텍스트 필드와의 간격
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
