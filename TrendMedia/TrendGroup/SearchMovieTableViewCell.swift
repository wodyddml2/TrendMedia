//
//  SearchMovieTableViewCell.swift
//  TrendMedia
//
//  Created by J on 2022/07/20.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieStory: UILabel!

    func configureCell(_ value: Movie) {
        movieTitle.font = .boldSystemFont(ofSize: 15)
        movieTitle.text = value.title
        movieYear.text = value.releaseDate
        movieStory.text = "\(value.overview) | \(value.runtime) | \(value.rate)"
        
       
        movieStory.numberOfLines = 0
    }
}
