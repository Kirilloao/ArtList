//
//  ViewController.swift
//  ArtList
//
//  Created by Kirill Taraturin on 07.11.2023.
//

import UIKit

final class AuthorsListViewController: UITableViewController {
    
    let authors = [
        UIImage(named: "0"), UIImage(named: "1"), UIImage(named: "2"),
        UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5"),
        UIImage(named: "6")
    ]
    
    var artists: [Author] = []
    
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
    }
    
    private func setTableView() {
        tableView.register(AuthorCell.self, forCellReuseIdentifier: AuthorCell.reuseID)
        tableView.separatorStyle = .none
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AuthorCell.reuseID, for: indexPath) as? AuthorCell else { return UITableViewCell() }
        
        let author = artists[indexPath.row]
        cell.configure(with: author)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - Networking
extension AuthorsListViewController {
    private func fetchAuthors(with url: String) {
        NetworkManager.shared.fetch(with: url) { result in
            switch result {
            case .success(let data):
                self.artists = data.artists
                self.tableView.reloadData()
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

