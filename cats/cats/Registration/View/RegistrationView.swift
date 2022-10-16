//
//  RegistrationView.swift
//  cats
//
//  Created by Майя Калицева on 14.10.2022.
//

import UIKit
import SnapKit

final class RegistrationView: UIView {
    
    // MARK: Private Properties
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundCats")
        return imageView
    }()
    
    private let registrationLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Helvetica", size: 25)
        lbl.textColor = UIColor.black
        lbl.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        lbl.clipsToBounds = true
        lbl.layer.cornerRadius = 10
        lbl.text = "Registration"
        return lbl
    }()
    
    private let welcomeImageView: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "cuteCat")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
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
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        emailTextField.becomeFirstResponder()
        purposeTextField.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
    
    private func setupLayout() {
        backgroundImage.addSubview(registrationLabel)
        backgroundImage.addSubview(welcomeImageView)
        backgroundImage.addSubview(emailTextField)
        backgroundImage.addSubview(purposeTextField)
        
        addSubview(backgroundImage)
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        registrationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(45)
        }
        
        welcomeImageView.snp.makeConstraints { make in
            make.width.equalTo(0)
            make.height.equalTo(300)
            make.top.equalTo(registrationLabel.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(welcomeImageView.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(50)
        }
        
        purposeTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).inset(-15)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(50)
        }
    }
}
