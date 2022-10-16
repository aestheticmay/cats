//
//  RegistrationCell.swift
//  cats
//
//  Created by Майя Калицева on 16.10.2022.
//

import UIKit

final class RegistrationCell: UITableViewCell {
    
    // MARK: Private Properties
    
    private let registrationLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Registration"
        lbl.textColor = UIColor.black
        lbl.font = UIFont(name: "Academy Engraved LET", size: 25)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        return lbl
    }()
    
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
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

    private func setupLayout() {
        contentView.addSubview(registrationLabel)

        registrationLabel.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
