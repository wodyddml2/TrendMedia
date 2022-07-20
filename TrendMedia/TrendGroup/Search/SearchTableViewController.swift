//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/19.
//

import UIKit

class SearchTableViewController: UITableViewController {

    let movieData = SearchDataInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell
        
        cell?.movieImage.image = UIImage(named: movieData.movie[indexPath.row].poster)
        cell?.movieTitle.text = movieData.movie[indexPath.row].names
        cell?.movieDate.text = movieData.movie[indexPath.row].days
        cell?.movieStory.text = movieData.movie[indexPath.row].storys
        
        return cell ?? tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell")!
    }
    // 디바이스 화면에 맞춰 높이 조정
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 8
    }


}
