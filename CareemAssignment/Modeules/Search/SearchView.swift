//
//  SearchView.swift
//  CareemAssignment
//
//  Created by Waqas Naseem on 09/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

class SearchView: UIView {
    var coordinator: AppCoordinator?
    private var viewModel: SearchViewModel!
    lazy var searchTextField : UITextField = {
        let txtField = UITextField()
        txtField.borderStyle = .roundedRect
        txtField.textColor = .black
        txtField.font = UIFont.boldSystemFont(ofSize: 16)
        txtField.textAlignment = .left
        txtField.delegate = self
        return txtField
    }()
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.startAnimating()
        activity.color = .gray
        return activity
    }()
    
    lazy var historyTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    var searchButton : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.blue, for: .normal)
        btn.setTitle("Search", for: .normal)
        btn.addTarget(self, action: #selector(onSearchAction), for: .touchUpInside)
        return btn
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setup() {
        backgroundColor = UIColor.white
        viewModel = SearchViewModel(delegate: self)
        addSubviews()
        setupConstraints()
        historyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "HistoryCell")
    }
    
    private func addSubviews() {
        [searchTextField,searchButton,activityIndicator,historyTableView].forEach{ addSubview($0)}
        historyTableView.isHidden = true
    }
    
    private func setupConstraints() {
        searchButton.anchor(top: self.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        searchTextField.anchor(top: searchButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        activityIndicator.setAnchorCenterOfParent()
        activityIndicator.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100, enableInsets: false)
        activityIndicator.isHidden = true
        historyTableView.anchor(top: searchTextField.bottomAnchor, left: searchTextField.leftAnchor, bottom: activityIndicator.topAnchor, right: searchTextField.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    }
    
    func clear() {
        searchTextField.text = ""
        activityIndicator.isHidden = true
    }
    
    private func toggleSearchHistoryAndResult(hideSearchHistory: Bool) {
        historyTableView.isHidden = hideSearchHistory
    }
    
    @objc func onSearchAction(sender: UIButton!) {
        guard let text = searchTextField.text, !text.isEmpty else {
//            AlertHandler.showAlert(self, message: "Please enter some movie name")
            return
        }
        activityIndicator.isHidden = false
        viewModel.search(with: text)
    }
}

 // MARK: - ViewModel Delegate
extension SearchView: ViewModelDelegate {
    
    func onViewModelReady(_ viewModel: BaseViewModel) {
        activityIndicator.isHidden = true
        guard self.viewModel.getNumberOfResults() > 0 else {
            coordinator?.showAlert(message: "No record Found")
            return
        }
        self.viewModel.saveSearchHistory(searchText: searchTextField.text)
        coordinator?.showMoviesList(viewModel: self.viewModel)
    }
    
    func onViewModelError(_ viewModel: BaseViewModel, error: NetworkError) {
        activityIndicator.isHidden = true
        coordinator?.showErrorAlert(error: error)
    }
}

//MARK: - Search History Table DataSource
extension SearchView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel == nil { return 0}
        return viewModel.getSearchHistory().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        cell.textLabel?.text = viewModel.getSearchHistory()[indexPath.row]
        return cell
    }
}

//MARK: - Search History Table Delegate
extension SearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let searchQuery = viewModel.getSearchHistory()[indexPath.row]
        searchTextField.text = searchQuery
        activityIndicator.isHidden = false
        viewModel.search(with: searchQuery)
        
    }
}

//MARK: - Textfield Delegate
extension SearchView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let searchHistory = viewModel.getSearchHistory()
        if(searchHistory.count > 0) {
            toggleSearchHistoryAndResult(hideSearchHistory: false)
            historyTableView.reloadData()
        } else {
            toggleSearchHistoryAndResult(hideSearchHistory: true)
        }
    }
}
