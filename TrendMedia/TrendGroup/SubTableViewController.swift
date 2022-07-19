//
//  SubTableViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/18.
//

import UIKit
// CaseIterable : 프로토콜, 배열처럼 열거형을 활용
enum SectionCase: Int, CaseIterable {
    case a
    case b
    case c
    
    var sectionTitle: String {
        switch self {
        case .a:
            return "전체 설정"
        case .b:
            return"개인 설정"
        case .c:
            return "기타"
        }
    }
    
    var rowTitle:[String] {
        switch self {
        case .a:
            return ["공지사항", "실험실", "버전 정보"]
        case .b:
            return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .c:
            return ["고객센터/도움말"]
        }
    }
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
        return SectionCase.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SectionCase.allCases[section].rowTitle.count
        
//        switch section {
//        case SectionCase.a.rawValue:
//            return SectionCase.s.rowTitle.count
//        case SectionCase.b.rawValue:
//            return SectionCase.b.rowTitle.count
//        case SectionCase.c.rawValue:
//            return SectionCase.c.rowTitle.count
//        default: return 0
//        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setName")!
       
        cell.textLabel?.text = SectionCase.allCases[indexPath.section].rowTitle[indexPath.row]
        return cell
        
//        switch indexPath.section {
//        case SectionCase.a.rawValue:
//            cell.textLabel?.text = firstArr[indexPath.row]
//
//        case SectionCase.b.rawValue:
//            cell.textLabel?.text = secondArr[indexPath.row]
//        case SectionCase.c.rawValue:
//            cell.textLabel?.text = "고객센터/도움말"
//        default: cell.textLabel?.text = "빈 공간"
//        }
//        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return SectionCase.allCases[section].sectionTitle
        
//        switch section {
//        case SectionCase.a.rawValue:
//            return "전체 설정"
//        case SectionCase.b.rawValue:
//            return "개인 설정"
//        case SectionCase.c.rawValue:
//            return "기타"
//        default: return "기타"
//        }
    }
    


}
