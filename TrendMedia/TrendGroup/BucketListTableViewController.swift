//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/19.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    
    var list = ["토르", "헤어질 결심", "탑건"]
    
    @IBOutlet weak var userTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        
        list.append("마녀")
        list.append("아이언맨")
   
    }
    @IBAction func userTextFieldEnter(_ sender: UITextField) {
        list.append(sender.text!)
        
        // 중요! 데이터 업테이트
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuketListTableViewCell", for: indexPath) as! BuketListTableViewCell
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
