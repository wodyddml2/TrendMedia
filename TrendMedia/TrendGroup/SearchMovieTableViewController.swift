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
