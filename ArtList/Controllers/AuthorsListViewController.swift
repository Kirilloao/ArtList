//
//  ViewController.swift
//  ArtList
//
//  Created by Kirill Taraturin on 07.11.2023.
//

import UIKit

final class AuthorsListViewController: UITableViewController {
    
    // MARK: - Private UI Properties
    private lazy var searchController: UISearchController = {
        var searchController = UISearchController(searchResultsController: nil)
        return searchController
    }()
    
    // MARK: - Private Properties
    private var artists: Artist!
    private var authors: [Author] = []
    

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationBar()
        fetchAuthors(with: Links.api.rawValue)
    }
    
    // MARK: - Private Methods
    private func setNavigationBar() {
        title = "Authors"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setTableView() {
        tableView.register(AuthorCell.self, forCellReuseIdentifier: AuthorCell.reuseID)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        authors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AuthorCell.reuseID,
                for: indexPath) as? AuthorCell
        else {
            return UITableViewCell()
        }
        
        let author = artists.artists[indexPath.row]
        cell.configure(with: author)
        cell.selectionStyle = .none
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.works = artists.artists[indexPath.row].works
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - Networking
extension AuthorsListViewController {
    private func fetchAuthors(with url: String) {
        NetworkManager.shared.fetch(with: url) { result in
            switch result {
            case .success(let data):
                self.artists = data
                self.authors = data.artists
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

