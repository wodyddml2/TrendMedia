//
//  SearchViewController.swift
//  TrendMedia
//
//  Created by J on 2022/07/19.
//

import UIKit

class SearchTableViewController: UITableViewController {

    let movieData = SearchData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return movieData.poster.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell
        
        cell?.movieImage.image = UIImage(named: movieData.poster[indexPath.row])
        cell?.movieTitle.text = movieData.names[indexPath.row]
        cell?.movieDate.text = movieData.days[indexPath.row]
        cell?.movieStory.text = movieData.storys[indexPath.row]
        
        return cell ?? tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell")!
    }


}
