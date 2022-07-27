//
//  BucketListTableViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/19.
//

import UIKit

struct Todo {
    var title: String
    var done: Bool
}

class BucketListTableViewController: UITableViewController {
    @IBOutlet weak var testTextField: UITextField!
    static let identifier = "BucketListTableViewController"
    
    // list  프로퍼티가 추가, 삭제 등 변경 되고 나서 테이블 뷰 항상 갱신
    var list = [Todo(title: "탑건", done: true), Todo(title: "토르", done: false)] {
        didSet {
            tableView.reloadData()
            print("list가 변경됨! \(list), \(oldValue)")
        }
    }
    //
    var placeHolder: String?
    // 옵셔널 스트링 타입으로 선언하더라도 오류가 뜨지 않는 이유?
    // placeholder 자체가 옵셔널이라면 : o
    // 하지만 String Interpolation이라면 : x
    
    // class는 reference타입 -> 인스턴스 자체를 변경하지 않는 이상 한 번만 호출
    // IBOutlet viewDidLoad가 호출되기 직전에 nil인지 아닌지 확인 가능
    @IBOutlet weak var userTextField: UITextField!  {
        didSet {
            userTextField.textAlignment = .center
            userTextField.font = .boldSystemFont(ofSize: 22)
            userTextField.textColor = .systemRed
            print("xpxpxpx")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.placeholder = placeHolder == nil ? "x" : placeHolder!
        navigationItem.title = "버킷리스트"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
        
        tableView.rowHeight = 80
        
//        list.append("마녀")
//        list.append("아이언맨")
   
    }
    @objc func closeButtonClicked() {
        self.dismiss(animated: true)
    }
    
    @IBAction func userTextFieldEnter(_ sender: UITextField) {
//        if let values = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !values.isEmpty, (2...6).contains(values.count){
//            list.append(values)
//            // 중요! 데이터 업테이트
//            tableView.reloadData()
//        } else {
//
//        }
//
//        guard let guardValue = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !guardValue.isEmpty, (2...6).contains(guardValue.count) else {
//            return
//        }
        
//        list.append(guardValue)
//        tableView.reloadData()
        
//        list.append(sender.text!)
        list.append(Todo(title: sender.text!, done: false))
//        tableView.reloadData()

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
        
        cell.buketlistLabel.text = list[indexPath.row].title
        cell.buketlistLabel.font = .boldSystemFont(ofSize: 18)
        
        cell.checkButton.tag = indexPath.row
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked(sender:)), for: .touchUpInside)
        
        let value = list[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
        cell.checkButton.setImage(UIImage(systemName: value), for: .normal)
        return cell
        
    }
    
    @objc func checkButtonClicked(sender:UIButton) {
        print("\(sender.tag)SS")
        
        list[sender.tag].done = !list[sender.tag].done
        // 배열 인덱스를 찾아서 done을 바꿔야한다. 그리고 테이블 뷰 갱신
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        
        
        // 재사용 cell 오류
//        sender.setImage(UIImage(named: "checkmark.square.fill"), for: .normal)
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
//            tableView.reloadData()
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
