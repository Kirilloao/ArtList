//
//  FullScreenImageViewController.swift
//  ArtList
//
//  Created by Kirill Taraturin on 07.11.2023.
//

import UIKit

final class FullScreenImageViewController: UIViewController {
    
    // MARK: - Private UI Properties
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleToFill
//        imageView.frame = view.bounds
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissFullScreen)
        )
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private lazy var closeButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.down.right.and.arrow.up.left"), for: .normal)
        button.addTarget(self, action: #selector(dismissFullScreen), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private var image: UIImage

    // MARK: - Init
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBlurEffect()
        setViews()
        setupConstraints()
    }
    
    // MARK: - Private Actions
    @objc private func dismissFullScreen() {
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(400)
        }
        
        closeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-5)
            make.right.equalToSuperview().offset(-5)
        }
    }
    
    private func setViews() {
        imageView.image = image
        view.addSubview(imageView)
        imageView.addSubview(closeButton)
//        view.addSubview(closeButton)
    }
    
    private func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
}
