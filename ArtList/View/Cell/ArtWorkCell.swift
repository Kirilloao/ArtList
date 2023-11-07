//
//  ArtWorkCell.swift
//  ArtList
//
//  Created by Kirill Taraturin on 07.11.2023.
//

import UIKit


final class ArtWorkCell: UITableViewCell {
    

    
    // MARK: - Static Properties
    static let reuseID = String(describing: ArtWorkCell.self)
    
    // MARK: - Private UI Properties
    private lazy var mainView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        var title = UILabel()
        title.text = "Guernica"
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textAlignment = .center
        title.numberOfLines = 2
        return title
    }()
    
    private lazy var workImageView: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        image.addGestureRecognizer(tapGesture)
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var infoLabel: UILabel = {
        var info = UILabel()
        info.numberOfLines = 0
        return info
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
    func configure(with work: Work) {
        titleLabel.text = work.title
        workImageView.image = UIImage(named: work.image)
        infoLabel.text = work.info
    }
    
    @objc private func imageTapped() {
 
    }
    
    // MARK: - Private Methods
    private func setViews() {
        contentView.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(workImageView)
        mainView.addSubview(infoLabel)
    }
    
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)

        }
        
        workImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
            make.height.equalTo(200)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(workImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
}
