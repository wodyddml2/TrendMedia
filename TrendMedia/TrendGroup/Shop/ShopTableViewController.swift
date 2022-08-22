//
//  ShopTableViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/19.
//

import UIKit

import RealmSwift

class ShopTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var searchBackground: UIView!
    @IBOutlet weak var shopTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    

    let localRealm = try! Realm()

    var taskList: Results<UserShopping>?
    var task: UserShopping?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shopTextField.delegate = self
        
        //UITextField+Extension
        shopTextField.borderDesign()
        
        searchButtonStyle()
        
        searchBackgroundStyle()
        
        taskList = localRealm.objects(UserShopping.self)
        
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func searchButtonClicked() {
        task = UserShopping(detail: shopTextField.text ?? "")
        try! localRealm.write{
            
            localRealm.add(task!)
            taskList = localRealm.objects(UserShopping.self)
            tableView.reloadData()
        }
        shopTextField.text = ""
    }
    
    // UIView 스타일
    func searchBackgroundStyle() {
        searchBackground.backgroundColor = UIColor(named: "ShopColor")
        searchBackground.layer.masksToBounds = true
        searchBackground.layer.cornerRadius = 10
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

        task = UserShopping(detail: shopTextField.text ?? "")
        try! localRealm.write{
            localRealm.add(task!)
            taskList = localRealm.objects(UserShopping.self)
            tableView.reloadData()
        }

        shopTextField.text = ""
        return true
    }
    
    // cell의 Height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // cell의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList?.count ?? 0
    }
    
    // cell 스타일
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell", for: indexPath) as? ShopTableViewCell
       
        cell?.cellStyle()
        
        cell?.checkBoxButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        cell?.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        
        if taskList?[indexPath.row].check == true {
            cell?.checkBoxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            cell?.checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        
        if taskList?[indexPath.row].favorite == true {
            cell?.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell?.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        cell?.shopListLabel.text = taskList?[indexPath.row].detail
        
       
        cell?.checkBoxButton.tag = indexPath.row
        cell?.favoriteButton.tag = indexPath.row
        
        return cell ?? tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell")!
    }

    
    @objc func checkButtonClicked(_ sender: UIButton) {
        let task = taskList?[sender.tag]
        if task?.check == true {
            try! localRealm.write {
                task?.check = false
                
            }
        } else {
            try! localRealm.write {
                task?.check = true
            }
        }
        tableView.reloadData()
    }
    
    @objc func favoriteButtonClicked(_ sender: UIButton) {
        let task = taskList?[sender.tag]
        if task?.favorite == true {
            try! localRealm.write {
                task?.favorite = false
                
            }
        } else {
            try! localRealm.write {
                task?.favorite = true
            }
        }
        tableView.reloadData()
    }
    
    // 편집 활성화
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 리스트 삭제
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            try! localRealm.write {
//                localRealm.deleteAll()
                localRealm.delete((taskList?[indexPath.row])!)
                tableView.reloadData()
            }
            
        }
    }
    // header의 높이를 주어서 위의 텍스트 필드와의 간격
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
