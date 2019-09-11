//
//  MovieListViewModel.swift
//  TubiChallenge
//
//  Created by Matthew Pileggi on 9/9/19.
//  Copyright © 2019 Matthew Pileggi. All rights reserved.
//

import Foundation

protocol MovieListViewModelDelegate: class {
    func didUpdate()
    func didReceiveError(_ error: NetworkError)
}

class MovieListViewModel {
    
    
    //MARK: Properties
    
    private var rowViewModels: [MovieListRowViewModel]?
    weak var delegate: MovieListViewModelDelegate?

    
    //MARK: Model update
    
    func fetch() {
        NetworkService.request(router: Router.getMovieList, completion: didReceiveMovieList)
    }
    
    private func didReceiveMovieList(result: Result<[MovieItem], NetworkError>) {
        switch result {
        case .success(let items):
            rowViewModels = items.map { MovieListRowViewModel(movieItem: $0)}
            delegate?.didUpdate()
        case .failure(let error):
            delegate?.didReceiveError(error)
        }
    }
    
    
    //MARK: Mapping
    
    var numberOfRows: Int {
        get {
            return rowViewModels?.count ?? 0
        }
    }
    
    func viewModelForRow(atIndex index: Int) -> MovieListRowViewModel? {
        guard let rowViewModels = rowViewModels, rowViewModels.count > index else {
            return nil
        }
        return rowViewModels[index]
    }

}
