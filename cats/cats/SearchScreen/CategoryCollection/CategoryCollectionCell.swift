//
//  CategoryCollectionCell.swift
//  cats
//
//  Created by Майя Калицева on 16.11.2022.
//

import UIKit

final class CategoryCollectionCell: UICollectionViewCell {
    
    // MARK: - Private Properties

    private let categoryLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "test"
        return lbl
    }()
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(model: [CategoryModel]) {
        model.map { $0.name }.forEach { categoryLabel.text = "\($0)" }
       // categoryLabel.text = model.name
    }
    
    // MARK: - Private Methods
    
    private func setupLayout() {
        addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
