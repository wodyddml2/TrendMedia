//
//  SearchMovieTableViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/20.
//

import UIKit

class SearchMovieTableViewController: UITableViewController {
    var movieList = MovieInfo().movie
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "처음으로", style: .plain, target: self, action: #selector(firstScreen))
        
        // command + shift + O : 원하는 파일로 이동
        // command + L : 원하는 라인으로 간다.
        // option + command + L : 커서가 있는 영역으로 데려다준다.
        // option+command [,] : 코드를 내리고 올릴 수 있다.
        // shift + ctrl : 커서를 여러개 만들고 한 번에 여러개 작성
        // ctrl + command + e : 같은 변수 코드 변경
        // ctrl + i : 드래그한 영역 정렬
        // ctrl + command: 코드의 간단한 구조
        // sipnet에서 placeholder만들기- <#두개>
        // option + command + / : ///주석이 나온다.
        
        //MARK: 뷰컨의 생명주기 (bold처리와 미니맵에서 크게 보인다.)
        ///시작화면으로 돌아가는 메서드(문서의  summary에 주석이 보인다.)
        
        
    }
    // 옵션에서 설명
    /// 셀
    /// - Parameters:
    ///   - data: sdsd
    @objc func firstScreen() {
        //iOS 13이상 SceneDelegate 쓸 때 동작하는 코드
        // 모든 메모리를 초기화하고 첫화면으로 다시 넘어갈때
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let sb = UIStoryboard(name: "Trend", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "SenceViewController") as! SenceViewController
        
        sceneDelegate?.window?.rootViewController = vc
        
        sceneDelegate?.window?.makeKeyAndVisible()
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchMovieTableViewCell" , for: indexPath) as? SearchMovieTableViewCell
        let data = movieList[indexPath.row]
        
        cell?.configureCell(data)
        
        return cell ?? tableView.dequeueReusableCell(withIdentifier: "SearchMovieTableViewCell")!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/8 // 디바이스 기준 비율
    }
}
