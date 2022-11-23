//
//  CategoryTableCell.swift
//  cats
//
//  Created by Майя Калицева on 23.11.2022.
//

import UIKit

final class CategoryTableCell: UITableViewCell {

    // MARK: - Private Properties
    
    private let categoryLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20)
        return lbl
    }()
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
    }
    
    
    // MARK: - Private Properties
    
    func setup(_ category: CategoryModel) {
        categoryLabel.text = category.name
    }
    
    private func setupLayout() {
        addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

