//
//  ArtWorkCell.swift
//  ArtList
//
//  Created by Kirill Taraturin on 07.11.2023.
//

import UIKit

protocol ArtWorkCellDelegate: AnyObject {
    func didTapImageView(in cell: ArtWorkCell)
}

final class ArtWorkCell: UITableViewCell {
    
    // MARK: - Public Properties
    var delegate: ArtWorkCellDelegate?
    
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
    
    lazy var workImageView: UIImageView = {
        var image = UIImageView()
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped)
        )
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
        delegate?.didTapImageView(in: self)
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
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(contentView.safeAreaLayoutGuide.snp.right).offset(-16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        workImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(130)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(workImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
