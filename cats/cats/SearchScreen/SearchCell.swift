//
//  SearchCell.swift
//  cats
//
//  Created by Майя Калицева on 27.10.2022.
//

import UIKit
import Kingfisher

final class SearchCell: UITableViewCell {

    // MARK: - Private Properties
    
    private let catImageView: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 10
        return img
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
        catImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
        contentMode = .scaleAspectFill
        layer.cornerRadius = 10
    }

    // MARK: - Private Properties
    
    func setup(_ cat: CatModel) {
        let url = cat.imageUrl
        guard let url = url else { return }
        catImageView.kf.setImage(with: ImageResource(downloadURL: url, cacheKey: url.absoluteString))
    }
    
    private func setupLayout() {
        addSubview(catImageView)
        
        catImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(200)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
