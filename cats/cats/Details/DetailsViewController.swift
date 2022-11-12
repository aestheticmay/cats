//
//  DetailsViewController.swift
//  cats
//
//  Created by Майя Калицева on 26.10.2022.
//

import UIKit
import Kingfisher

final class DetailsViewController: UIViewController {
    
    // MARK: - Private Properties

    private let cats: CatModel
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let breedsLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.font = UIFont(name: "Times New Roman", size: 25)
        return lbl
    }()
    
    private lazy var likeButton: UIButton = {
        let btn = UIButton()
        let scale = UIImage.SymbolConfiguration(pointSize: 50, weight: .light, scale: .default)
        let like = UIImage(systemName: "suit.heart")?.withTintColor(UIColor.red)
        let unlike = UIImage(systemName: "suit.heart.fill", withConfiguration: scale)?.withTintColor(UIColor.red)
        btn.setImage(unlike, for: .normal)
        btn.setImage(like, for: .selected)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.tintColor = UIColor.red
        return btn
    }()
    
    private let scrollView = UIScrollView()
    
    private let scrollStackViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    // MARK: - Init
    
    init(cats: CatModel) {
        self.cats = cats
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configure()
    }
    
    // MARK: - Private Methods
    
    private func configure() {
        title = cats.identifier
        let url = cats.imageUrl
        guard let url = url else { return }
        imageView.kf.setImage(with: ImageResource(downloadURL: url, cacheKey: url.absoluteString))
        if cats.breeds.isEmpty {
            breedsLabel.text = "ღ Breed: unknown"
        } else {
            cats.breeds.map { $0.name }.forEach { breedsLabel.text = "ღ Breeds: \($0)" }
        }
    }
    
    private func setupLayout() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Academy Engraved LET", size: 25)!]
        navigationController?.navigationBar.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
        let margins = view.layoutMarginsGuide
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(margins.snp.top)
            make.bottom.equalTo(margins.snp.bottom)
        }
        
        scrollStackViewContainer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalTo(scrollView.snp.bottom)
            make.width.equalTo(scrollView.snp.width)
        }
        
        scrollStackViewContainer.addArrangedSubview(imageView)
        scrollStackViewContainer.addArrangedSubview(likeButton)
        scrollStackViewContainer.addArrangedSubview(breedsLabel)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo(UIScreen.main.bounds.width - 30)
            make.top.equalToSuperview().inset(15)
            make.bottom.equalTo(likeButton.snp.top).inset(-15)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(breedsLabel.snp.top).inset(-10)
        }
        
        breedsLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).inset(10)
            make.leading.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
}

