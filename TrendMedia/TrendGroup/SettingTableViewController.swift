//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    var birthdayFriends = ["뽀로로", "아구몬", "삐삐", "우솝","나루토", "조로"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
       
    }
    // 0. 색션의 갯수(옵션)
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section"
    }

    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "생일"
        } else if section == 1 {
            return "즐겨찾기"
        } else if section == 2 {
            return "친구 140명"
        } else {
            return "section"
        }
    }
    
    
    // 1. 셀의 갯수(필수)
    // ex. 카톡 100명 -> 셀 100개
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return birthdayFriends.count
        } else if section == 1 {
            return 4
        } else if section == 2 {
            return 12
        } else {
            return 3
        }
  
    }
    
    
    // 2. 셀의 디자인과 데이터(필수)
    // ex. 카톡 이름, 프로필 사진, 상태 메세지 등
    // 재사용 메커니즘
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("cellForRowAt", indexPath)
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "rightDetailCell")!
            cell.textLabel?.text = "2번 텍스트"
            cell.textLabel?.textColor = .systemCyan
            cell.textLabel?.font = .boldSystemFont(ofSize: 17)
            cell.detailTextLabel?.text = "디테일 레이블"
//             indexPath.row % 2 == 0,1
            
            if indexPath.row % 2 == 0 {
                cell.imageView?.image = UIImage(systemName: "star")
                cell.backgroundColor = .lightGray
            } else {
                cell.imageView?.image = UIImage(systemName: "star.fill")
                cell.backgroundColor = .white
            }
            
            cell.imageView?.image = indexPath.row % 2 == 0 ? UIImage(systemName: "star") : UIImage(systemName: "star.fill")
            
            cell.backgroundColor = indexPath.row % 2 == 0 ? .lightGray : .white
            
            
            return cell
        } else {
            
            // 복.붙과 같은 효과
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
            
            if indexPath.section == 0 {
                cell.textLabel?.text = birthdayFriends[indexPath.row]
                cell.textLabel?.textColor = .systemBlue
                cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            } else if indexPath.section == 1 {
                cell.textLabel?.text = "1번 텍스트"
                cell.textLabel?.textColor = .systemIndigo
                cell.textLabel?.font = .boldSystemFont(ofSize: 15)
            }
            return cell
        }
        
       
    }
    
    // 셀의 높이(옵션, 빈도 높은) (feat. tableView.rowHeight)
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }


}
