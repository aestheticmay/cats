//
//  DetailsViewController.swift
//  cats
//
//  Created by Майя Калицева on 26.10.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var catModel: CatModel?
    
    private let imageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "cuteCat")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let breedsLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = UIColor.black
        lbl.font = UIFont(name: "Times New Roman", size: 30)
        return lbl
    }()
    
    private let categoriesLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont(name: "Times New Roman", size: 30)
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
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupLayout()
        configure()
    }
    
    // MARK: - Public Methods
    
    func configure() { //TODO remove later
        breedsLabel.text = "ღ Breeds: "
        categoriesLabel.text = "ღ Categories: "
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationController() {
        navigationController?.navigationBar.backItem?.title = catModel?.identifier
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = UIColor.white
    }
   
    private func setupLayout() {
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
        scrollStackViewContainer.addArrangedSubview(categoriesLabel)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo((UIScreen.main.bounds.width - 30) * (imageView.image?.size.height ?? 0) / (imageView.image?.size.width ?? 0))
            make.top.equalToSuperview()
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
            make.bottom.equalTo(categoriesLabel.snp.top).inset(-10)
        }
        
        categoriesLabel.snp.makeConstraints { make in
            make.top.equalTo(breedsLabel.snp.bottom).inset(10)
            make.leading.equalToSuperview().inset(10)
        }
    }
}

