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
    
    private var switchButton = UIBarButtonItem()
    
    // MARK: - Private Properties
    private var isLight = true
    private var artists: Artist?
    private var authors: [Author] = []
    private var filteredAuthors: [Author] = []
    
    // MARK: - Computed Properties
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setNavigationBar()
        setupSearchController()
        setupSwitchButton()
        fetchAuthors(with: Links.api.rawValue)
    }
    
    // MARK: - Private Actions
    @objc private func switchButtonDidTapped() {
        
        isLight.toggle()
        
        switchButton.title = isLight ? "Dark" : "Light"
        switchButton.tintColor = isLight ? .black : .white
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            sceneDelegate.toggleAppearance(animated: true)
        }
    }
    
    // MARK: - Private Methods
    private func setNavigationBar() {
        title = "Authors"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSwitchButton() {
        switchButton = UIBarButtonItem(
            title: "Dark",
            style: .done,
            target: self,
            action: #selector(switchButtonDidTapped)
        )
        switchButton.tintColor = .black
        navigationItem.rightBarButtonItem = switchButton
    }
    
    private func setTableView() {
        tableView.register(AuthorCell.self, forCellReuseIdentifier: AuthorCell.reuseID)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.barTintColor = .white
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering
        ? filteredAuthors.count
        : authors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AuthorCell.reuseID,
                for: indexPath) as? AuthorCell
        else {
            return UITableViewCell()
        }
        
        let author = isFiltering
        ? filteredAuthors[indexPath.row]
        : authors[indexPath.row]
        
        cell.configure(with: author)
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController()
        detailsVC.works = isFiltering ? filteredAuthors[indexPath.row].works :
        authors[indexPath.row].works
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

// MARK: - UISearchResultsUpdating
extension AuthorsListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredAuthors = authors.filter{ author in
            author.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
}
