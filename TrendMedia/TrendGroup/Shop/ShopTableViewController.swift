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
    
    let repository = UserShoppingRepository()


    private var taskList: Results<UserShopping>? {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "ShoppingList"
        if #available(iOS 14.0, *) {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "정렬", primaryAction: nil, menu: sortedMenuAction())
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortedAlertAction))
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "백업/복구", style: .plain, target: self, action: #selector(backupButtonClicked))

        shopTextField.delegate = self
        
        //UITextField+Extension
        shopTextField.borderDesign()
        
        searchButtonStyle()
        
        searchBackgroundStyle()
        
        taskList = repository.fetch()
        
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }
    
    @objc func backupButtonClicked() {
        guard let vc = UIStoryboard(name: "Shopping", bundle: nil).instantiateViewController(withIdentifier: "BackupViewController") as? BackupViewController else {return}
     
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func sortedMenuAction() -> UIMenu {
        let favorite = UIAction(title: "즐겨찾기순", image: UIImage(systemName: "star")) { _ in
            
            self.taskList = self.repository.fetchSort(sort: "favorite", ascending: false)

        }
        let check = UIAction(title: "미체크순", image: UIImage(systemName: "checkmark.square")) { _ in
            
            self.taskList = self.repository.fetchSort(sort: "check", ascending: true)
        }
        
        let title = UIAction(title: "제목순", image: UIImage(systemName: "character")) { _ in
            self.taskList = self.repository.fetchSort(sort: "detail", ascending: true)
        }
        
        let menu = UIMenu(title: "리스트 정렬", identifier: nil, options: .displayInline, children: [title, favorite, check])
        
        return menu
    }
    
    @objc private func sortedAlertAction() -> UIAlertController {
        let alert = UIAlertController(title: "리스트 정렬", message: nil, preferredStyle: .actionSheet)
        
        let favorite = UIAlertAction(title: "즐겨찾기순", style: .default) { _ in
            self.taskList = self.repository.fetchSort(sort: "favorite", ascending: false)
        }
        let check = UIAlertAction(title: "미체크순", style: .default) { _ in
            self.taskList = self.repository.fetchSort(sort: "check", ascending: true)
            
        }
        let title = UIAlertAction(title: "제목순", style: .default) { _ in
            self.taskList = self.repository.fetchSort(sort: "detail", ascending: true)
        }
        [favorite, check, title].forEach {
            alert.addAction($0)
        }
        return alert
    }

    @objc func searchButtonClicked() {
        let task = UserShopping(detail: shopTextField.text ?? "")
        repository.addRealm(item: task, list: &(taskList)!)
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

        let task = UserShopping(detail: shopTextField.text ?? "")
        repository.addRealm(item: task, list: &(taskList)!)

        shopTextField.text = ""
        return true
    }
    
    // cell의 Height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
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
        
        cell?.shoplistImageView.image = UIImage(systemName: "star")
        
        cell?.checkBoxButton.tag = indexPath.row
        cell?.favoriteButton.tag = indexPath.row
        
        return cell ?? tableView.dequeueReusableCell(withIdentifier: "ShopTableViewCell")!
    }

    
    @objc func checkButtonClicked(_ sender: UIButton) {
        let task = taskList?[sender.tag]
        repository.updateCheck(item: task!, list: &taskList!)
    }
    
    @objc func favoriteButtonClicked(_ sender: UIButton) {
        let task = taskList?[sender.tag]
        repository.updateFavorite(item: task!, list: &taskList!)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .fade)
        guard let cell = tableView.cellForRow(at: indexPath) as? ShopTableViewCell else {return}
        saveImageToDocument(fileName: "\(taskList![indexPath.item].objectID).jpg", image: cell.shoplistImageView.image!)
        
        guard let vc = UIStoryboard(name: "Shopping", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {return}
        vc.shoppingInfoHandler = { 
            vc.shoppingDetailLabel.text = self.taskList?[indexPath.row].detail
            vc.objectId = self.taskList?[indexPath.row].objectID
        }
        
        present(vc, animated: true)
    }
    
    // 편집 활성화
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 리스트 삭제
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let tasks = taskList else {
                return
            }
            repository.deleteRealm(item: tasks[indexPath.row], list: &taskList!)
           
        }
    }
    // header의 높이를 주어서 위의 텍스트 필드와의 간격
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
