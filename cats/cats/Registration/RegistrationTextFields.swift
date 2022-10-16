//
//  RegistrationTextFields.swift
//  cats
//
//  Created by Майя Калицева on 16.10.2022.
//

import UIKit

final class RegistrationTextFields: UITableViewCell {
    
    // MARK: Public Properties
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Your email"
        tf.backgroundColor = UIColor.white
        tf.clipsToBounds = true
        tf.textColor = UIColor.black
        tf.layer.cornerRadius = 15
        tf.clearsOnBeginEditing = true
        tf.keyboardType = .default
        tf.textAlignment = .left
        return tf
    }()
    
    let purposeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Your purpose"
        tf.clipsToBounds = true
        tf.backgroundColor = UIColor.white
        tf.textColor = UIColor.black
        tf.layer.cornerRadius = 15
        tf.clearsOnBeginEditing = true
        tf.keyboardType = .default
        tf.textAlignment = .left
        return tf
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
        contentView.addSubview(emailTextField)
        contentView.addSubview(purposeTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalTo(purposeTextField.snp.top).inset(-15)
        }
        
        purposeTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).inset(15)
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(15)
        }
    }
}
