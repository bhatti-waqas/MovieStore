//
//  SearchViewController.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 07/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    public static func create(rootView: SearchView) -> UIViewController {
        let searchViewController = SearchViewController(rootView: rootView)
        return searchViewController
    }
    
    private var rootView: SearchView
    private var viewModel: SearchViewModel!
    
    init(rootView: SearchView) {
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rootView.clear()
    }
}
