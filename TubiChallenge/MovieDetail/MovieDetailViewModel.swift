//
//  MovieDetailViewModel.swift
//  TubiChallenge
//
//  Created by Matthew Pileggi on 9/10/19.
//  Copyright © 2019 Matthew Pileggi. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelDelegate: class {
    func didUpdate()
    func didReceiveError(_ error: NetworkError)
}

class MovieDetailViewModel {

    
    //MARK: Properties
    
    private let id: String
    private var details: MovieItem?
    private var cache = CacheProvider.movieItemCache
    weak var delegate: MovieDetailViewModelDelegate?

    
    //MARK: Init
    
    init(id: String) {
        self.id = id
    }
    
    
    //MARK: Model update
    
    func fetch() {
        if let movieItem = cache.getObject(forKey: id) {
            details = movieItem
            delegate?.didUpdate()
            return
        }
        
        NetworkService.request(router: Router.getMovieDetails(id), completion: didReceiveMovieDetails)
    }
    
    private func didReceiveMovieDetails(result: Result<MovieItem, NetworkError>) {
        switch result {
        case .success(let item):
            details = item
            delegate?.didUpdate()
            cache.add(object: item, withKey: item.id)
        case .failure(let error):
            delegate?.didReceiveError(error)
        }
    }
    
    
    //MARK: Mapping
    
    var imageUrl: URL? {
        get {
            guard let stringRepresentation = details?.image else {
                return nil
            }
            return URL(string: stringRepresentation)
        }
    }
    
    var title: String? {
        get {
            return details?.title
        }
    }
    
    var index: Int? {
        get {
            return details?.index
        }
    }
    
}
