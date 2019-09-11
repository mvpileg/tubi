//
//  MovieDetailViewController.swift
//  TubiChallenge
//
//  Created by Matthew Pileggi on 9/10/19.
//  Copyright © 2019 Matthew Pileggi. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    
    //MARK: Outlets
    
    @IBOutlet var movieDetailView: MovieDetailView!
    
    
    //MARK: Actions
    @IBAction func refresh(_ sender: Any) {
        viewModel?.fetch()
    }
    
    
    //MARK: Properties
    
    var id: String?
    private var viewModel: MovieDetailViewModel?
    
    
    //MARK: View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    
    //MARK: Private
    
    private func setupViewModel() {
        guard let id = id else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        viewModel = MovieDetailViewModel(id: id)
        viewModel?.delegate = self
        viewModel?.fetch()
    }
}


//MARK: MovieDetailViewModelDelegate

extension MovieDetailViewController: MovieDetailViewModelDelegate {
    
    func didUpdate() {
        DispatchQueue.main.async {
            self.movieDetailView.load(viewModel: self.viewModel)
        }
    }
    
    func didReceiveError(_ error: NetworkError) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: "Failed to retrieve movie details", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
