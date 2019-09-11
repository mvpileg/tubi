//
//  MovieDetailView.swift
//  TubiChallenge
//
//  Created by Matthew Pileggi on 9/10/19.
//  Copyright © 2019 Matthew Pileggi. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailView: UIView {

    
    //MARK: Outlets
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var index: UILabel!
    
    
    //MARK: Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        
        title.font = UIFont.systemFont(ofSize: 24)
        
        index.font = UIFont.systemFont(ofSize: 16)
    }
    
    //MARK: View setup
    
    func load(viewModel: MovieDetailViewModel?) {
        guard let viewModel = viewModel else {
            image.image = nil
            title.text = nil
            index.text = nil
            return
        }
        image.sd_setImage(with: viewModel.imageUrl, completed: nil)
        title.text = viewModel.title
        index.text = "Index: \(indexStringFor(viewModel: viewModel))"
    }
    
    
    //MARK: Private
    
    private func indexStringFor(viewModel: MovieDetailViewModel) -> String {
        if let index = viewModel.index {
            return "\(index)"
        }
        return "unknown"
    }

}
