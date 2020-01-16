//
//  AppCoordinator.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 09/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set}
    var navigationControler: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationControler: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationControler = navigationController
    }
    
    func start() {
        let searchView = SearchView()
        searchView.coordinator = self
        let vc = SearchViewController(rootView: searchView)
        navigationControler.pushViewController(vc, animated: true)
    }
    
    func showMoviesList(viewModel: SearchViewModel) {
        let movieListView = MoviesListViewController.create(viewModel: viewModel)
        navigationControler.pushViewController(movieListView, animated: true)
    }
    
    public func showAlert(title:String = "", message: String) {
        guard let topController = navigationControler.topViewController else {
            return
        }
        AlertHandler.showAlert(topController, title: title, message: message)
    }
    
    public func showErrorAlert(error: NetworkError) {
        guard let topController = navigationControler.topViewController else {
            return
        }
        AlertHandler.showError(topController, error: error)
    }

}
