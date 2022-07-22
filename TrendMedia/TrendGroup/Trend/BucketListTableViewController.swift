//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/19.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    static let identifier = "BucketListTableViewController"
    var list = ["토르", "헤어질 결심", "탑건"]
    //
    var placeHolder: String?
    // 옵셔널 스트링 타입으로 선언하더라도 오류가 뜨지 않는 이유?
    // placeholder 자체가 옵셔널이라면 : o
    // 하지만 String Interpolation이라면 : x
    
    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.placeholder = placeHolder == nil ? "x" : placeHolder!
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        
        tableView.rowHeight = 80
        
        list.append("마녀")
        list.append("아이언맨")
   
    }
    @objc func closeButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @IBAction func userTextFieldEnter(_ sender: UITextField) {
        if let values = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !values.isEmpty, (2...6).contains(values.count){
            list.append(values)
            // 중요! 데이터 업테이트
            tableView.reloadData()
        } else {
            
        }
        
        guard let guardValue = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !guardValue.isEmpty, (2...6).contains(guardValue.count) else {
            return
        }
        
        list.append(guardValue)
        tableView.reloadData()

        // 개별 갱신
//        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
//        tableView.reloadSections(IndexSet(, with: <#T##UITableView.RowAnimation#>)
//        print(list)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BuketListTableViewCell.identifier, for: indexPath) as! BuketListTableViewCell
        cell.buketlistLabel.text = list[indexPath.row]
        cell.buketlistLabel.font = .boldSystemFont(ofSize: 18)
        
        return cell
        
    }
    // 편집 스와이프
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // 우측 스와이프 디폴트 기능: commit EditingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 배열 삭제 후 테이블 뷰 갱신
            list.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
    // 즐겨찾기 핀고정
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
}
