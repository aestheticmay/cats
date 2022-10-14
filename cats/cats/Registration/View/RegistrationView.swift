//
//  RegistrationView.swift
//  cats
//
//  Created by Майя Калицева on 14.10.2022.
//

import UIKit

final class RegistrationView: UIView {
    
    // MARK: Public Properties
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Gmail"
        tf.textColor = UIColor.black
        return tf
    }()
    
    let purposeTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Your purpose"
        return tf
    }()
    
    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private Methods
