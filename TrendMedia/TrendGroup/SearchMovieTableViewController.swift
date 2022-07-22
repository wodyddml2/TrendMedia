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
    }
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
