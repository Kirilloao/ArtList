//
//  DetailsViewController.swift
//  ArtList
//
//  Created by Kirill Taraturin on 07.11.2023.
//

import UIKit


final class DetailsViewController: UITableViewController {
    
    // MARK: - Public Methods
    var works: [Work]!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setupNavigationBar()
        
    }
    
    // MARK: - Private Methods
    private func setTableView() {
        tableView.register(ArtWorkCell.self, forCellReuseIdentifier: ArtWorkCell.reuseID)
        tableView.separatorStyle = .none
    }
    
    private func setupNavigationBar() {
        title = "Works"
    }
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        works.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ArtWorkCell.reuseID,
                for: indexPath) as? ArtWorkCell
        else {
            return UITableViewCell()
        }
        
        let work = works[indexPath.row]
        
        cell.configure(with: work)
        cell.selectionStyle = .none
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        250
        UITableView.automaticDimension
    }
    
}

// MARK: - ArtWorkCellDelegate
extension DetailsViewController: ArtWorkCellDelegate {
    func didTapImageView(in cell: ArtWorkCell) {
        guard let indexPath = tableView.indexPath(for: cell),
              let image = cell.workImageView.image else { return }
        
        let fullScreenVC = FullScreenImageViewController(image: image)
        fullScreenVC.modalPresentationStyle = .overFullScreen
        fullScreenVC.modalTransitionStyle = .crossDissolve
        present(fullScreenVC, animated: true)
    }
}
