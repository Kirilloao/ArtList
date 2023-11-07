//
//  AuthorCell.swift
//  ArtList
//
//  Created by Kirill Taraturin on 07.11.2023.
//

import UIKit
import SnapKit

final class AuthorCell: UITableViewCell {
    
    // MARK: - Static Properties
    static let reuseID = String(describing: AuthorCell.self)
    
    // MARK: - Private UI Properties
    private lazy var mainView: UIView = {
        var view = UIView()
//        view.backgroundColor = UIColor(red: 0.96, green: 0.90, blue: 0.55, alpha: 1.00)
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var authorImageView: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.text = "Pablo Ruiz y Picasso (25 October 1881 â€“ 8 April 1973), also known as Pablo Picasso, was a Spanish painter, sculptor, printmaker, ceramicist, stage designer, poet and playwright who spent most of his adult life in France."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with image: UIImage) {
        authorImageView.image = image
    }
    
    // MARK: - Private Methods
    private func setViews() {
        addSubview(mainView)
        mainView.addSubview(authorImageView)
        mainView.addSubview(descriptionLabel)
//        addSubview(authorImageView)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        authorImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(authorImageView.snp.right).offset(10)
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
