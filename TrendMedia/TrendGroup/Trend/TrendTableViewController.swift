//
//  TrendTableViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/21.
//

import UIKit

class TrendTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func movieButtonClicked(_ sender: UIButton) {
        // 화면 전환: 스토리보드 파일 찾기 2. 스토리 보드 내에 있는 뷰컨 찾고 3. 화면전환
        // 영화 버튼 클릭 > BucketlistTableViewController Present
        // 1.
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        // 2.
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        // 3.
        self.present(vc, animated: true)
    }
    
    @IBAction func dramaButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        // 2.
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        // 2.5
        vc.modalPresentationStyle = .fullScreen
        // 3.
        self.present(vc, animated: true)
    }
    @IBAction func bookButtonClicked(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        // 2.
        let vc = sb.instantiateViewController(withIdentifier: BucketListTableViewController.identifier) as! BucketListTableViewController
        // 2.5
        let nav = UINavigationController(rootViewController: vc)
        
        // 2.5
        nav.modalPresentationStyle = .fullScreen
        // 3.
        self.present(nav, animated: true)
    }
    

}
