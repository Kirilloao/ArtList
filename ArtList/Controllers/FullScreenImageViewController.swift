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
        imageView.contentMode = .scaleAspectFit
        imageView.frame = view.bounds
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissFullScreen)
        )
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    private let image: UIImage
    
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
    }
    
    // MARK: - Private Actions
    @objc private func dismissFullScreen() {
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func setViews() {
        imageView.image = image
        view.addSubview(imageView)
    }
    
    private func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .dark) // Или .light, .extraLight в зависимости от желаемого эффекта
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
}
