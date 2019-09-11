//
//  MovieListViewController.swift
//  TubiChallenge
//
//  Created by Matthew Pileggi on 9/9/19.
//  Copyright © 2019 Matthew Pileggi. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    
    //MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Actions
    
    @IBAction func refresh(_ sender: Any) {
        viewModel.fetch()
    }

    
    //MARK: Properties
    
    var viewModel: MovieListViewModel!
    
    
    //MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailViewController, let sender = sender as? MovieListRowViewModel {
            destination.id = sender.id
        }
    }
    
    
    //MARK: Setup
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 132
    }
    
    private func setupViewModel() {
        viewModel = MovieListViewModel()
        viewModel.delegate = self
        viewModel.fetch()
    }
    
}


//MARK: MovieListViewModelDelegate

extension MovieListViewController: MovieListViewModelDelegate {
    func didUpdate() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didReceiveError(_ error: NetworkError) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: "Failed to retrieve movie list", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            alertController.addAction(dismissAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}


//MARK: UITableViewDelegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "details", sender: viewModel.viewModelForRow(atIndex: indexPath.row))
    }
}


//MARK: UITableViewDataSource

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "list item") as? MovieListTableViewCell else {
            return UITableViewCell()
        }
        cell.load(viewModel: viewModel?.viewModelForRow(atIndex: indexPath.row))
        return cell
    }
}
