//
//  MovieListTableViewCell.swift
//  TubiChallenge
//
//  Created by Matthew Pileggi on 9/9/19.
//  Copyright © 2019 Matthew Pileggi. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListTableViewCell: UITableViewCell {
    
    
    //MARK: Outlets
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    
    //MARK: Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieImage.clipsToBounds = true
        movieImage.layer.cornerRadius = 5
        
        movieTitle.font = UIFont.systemFont(ofSize: 22)
        movieTitle.adjustsFontSizeToFitWidth = true
    }
    
    func load(viewModel: MovieListRowViewModel?) {
        guard let viewModel = viewModel else {
            movieImage.image = nil
            movieTitle.text = nil
            return
        }
        movieTitle.text = viewModel.title
        movieImage.sd_setImage(with: viewModel.imageURL, completed: nil)
    }

}
