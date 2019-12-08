//
//  SearchViewController.swift
//  HookahPlaces
//
//  Created by Евгений on 25/11/2019.
//  Copyright © 2019 Momotov. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    private var presenter: SearchPresenterProtocol!
    
    private let searchView = SearchView()
    private let filterButton = UIButton()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SearchPresenter(view: self)
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    @objc
    private func didEditingSearchTextField() {
        let text = searchView.textField.text ?? ""
        presenter.searchPlace(text)
    }
    
    private func openDetailPlace(_ place: Place) {
        let controller = DetailPlaceViewController()
        controller.presenter = DetailPlacePresenter(view: controller, place: place)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.places.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openDetailPlace(presenter.places[indexPath.row])
    }
}

extension SearchViewController {
    private func configureView() {
        title = "Search"
        view.backgroundColor = .white
        addFilterButton()
        addSearchView()
        addTableView()
    }
    
    private func addSearchView() {
        searchView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchView)
        
        searchView.snp.makeConstraints {
            $0.left.top.equalToSuperview()
            $0.right.equalTo(filterButton.snp.left)
            $0.height.equalTo(60)
        }
        
        searchView.textField.addTarget(self, action: #selector(didEditingSearchTextField), for: .editingChanged)
    }
    
    private func addFilterButton() {
        filterButton.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        filterButton.imageView?.tintColor = .black
        filterButton.backgroundColor = .white
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterButton)
        
        filterButton.snp.makeConstraints {
            $0.right.top.equalToSuperview()
            $0.height.width.equalTo(60)
        }
    }
    
    private func addTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .groupTableViewBackground
        tableView.keyboardDismissMode = .onDrag
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(searchView.snp.bottom)
        }
        
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(SearchPlaceCell.self, forCellReuseIdentifier: SearchPlaceCell.identifier)
    }
    
    private func cell(at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchPlaceCell.identifier, for: indexPath) as? SearchPlaceCell else {
            return UITableViewCell()
        }
        cell.set(presenter.places[indexPath.row])
        return cell
    }
}
