//
//  SubTableViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/18.
//

import UIKit

enum Section: Int {
    case a
    case b
    case c
}

class SubTableViewController: UITableViewController {

    @IBOutlet weak var tabelLabel: UILabel!
    
    
    
    let firstArr = ["공지사항", "실험실", "버전 정보"]
    let secondArr = ["개인/보안", "알림", "채팅", "멀티프로필"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelLabel.font = .boldSystemFont(ofSize: 17)
        tabelLabel.text = "설정"
        tabelLabel.textAlignment = .center
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.a.rawValue:
            return 3
        case Section.b.rawValue:
            return 4
        case Section.c.rawValue:
            return 1
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setName")!
        
        
        switch indexPath.section {
        case Section.a.rawValue:
            cell.textLabel?.text = firstArr[indexPath.row]
            
        case Section.b.rawValue:
            cell.textLabel?.text = secondArr[indexPath.row]
        case Section.c.rawValue:
            cell.textLabel?.text = "고객센터/도움말"
        default: cell.textLabel?.text = "빈 공간"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        switch section {
        case Section.a.rawValue:
            return "전체 설정"
        case Section.b.rawValue:
            return "개인 설정"
        case Section.c.rawValue:
            return "기타"
        default: return "기타"
        }
    }
    


}
