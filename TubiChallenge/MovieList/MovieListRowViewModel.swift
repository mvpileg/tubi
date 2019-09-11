//
//  MovieListRowViewModel.swift
//  TubiChallenge
//
//  Created by Matthew Pileggi on 9/9/19.
//  Copyright © 2019 Matthew Pileggi. All rights reserved.
//

import Foundation

class MovieListRowViewModel {
    
    
    //MARK: Properties
    
    private let movieItem: MovieItem
    
    
    //MARK: Init
    
    init(movieItem: MovieItem) {
        self.movieItem = movieItem
    }
    
    
    //MARK: Mapping
    
    var title: String {
        get {
            return movieItem.title
        }
    }

    var imageURL: URL? {
        get {
            return URL(string: movieItem.image)
        }
    }

    var id: String {
        get {
            return movieItem.id
        }
    }

}
