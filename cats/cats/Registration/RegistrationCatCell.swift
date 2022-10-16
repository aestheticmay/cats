//
//  RegistrationCatCell.swift
//  cats
//
//  Created by Майя Калицева on 16.10.2022.
//

import UIKit

final class RegistrationCatCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private let catImageView: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "cuteCat")
        img.contentMode = .scaleAspectFit
        return img
    }()

   // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLogoLayout()
        setupCellStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods

    private func setupCellStyle() {
        backgroundColor = .clear
        selectionStyle = .none
    }

    private func setupLogoLayout() {
        contentView.addSubview(catImageView)

        catImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 30)
            make.height.equalTo((UIScreen.main.bounds.width - 30) * (catImageView.image?.size.height ?? 0) / (catImageView.image?.size.width ?? 0))
            make.top.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(10)
          //  make.size.equalTo(100)
        }
    }
}
