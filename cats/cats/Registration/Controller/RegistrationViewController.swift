//
//  RegistrationViewController.swift
//  cats
//
//  Created by Майя Калицева on 15.10.2022.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    // MARK: Public Properties
    
    // MARK: Private Properties
    
    private let registrationView = RegistrationView()
    
    // MARK: Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupLayout()
    }
    
    // MARK: Public Methods
    
    // MARK: Private Methods
    
    private func setupLayout() {
        view.addSubview(registrationView)
        
        registrationView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
    
}
