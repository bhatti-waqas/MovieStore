//
//  MoviesListViewController.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 06/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

class MoviesListViewController: UITableViewController {
    
    private var viewModel: SearchViewModel!
    public static func create(viewModel: SearchViewModel) -> UIViewController {
        let moviesList = MoviesListViewController()
        moviesList.viewModel = viewModel
        return moviesList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        self.tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCellID")
        self.title = "Movies"
        setupFooter()
    }
    
    private func setupFooter() {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        tableView.tableFooterView = spinner
        tableView.tableFooterView?.isHidden = true
    }
    
    private func bindViewModel() {
        viewModel.moreDataLoaded.bind { [weak self] (value) in
            self?.updateUI()
        }
    }

    private func updateUI() {
        tableView.tableFooterView?.isHidden = true
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfResults()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCellID", for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        guard let cellViewModel = viewModel.movieCellViewModel(at: indexPath.row) else {
            return cell
        }
        cell.bind(movie: cellViewModel)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.viewModel.getNumberOfResults() - 1 {
            //load more
            guard viewModel.hasMore() else {
                tableView.tableFooterView?.isHidden = true
                return
            }
            tableView.tableFooterView?.isHidden = false
            viewModel.loadMore()
        }
    }
}
