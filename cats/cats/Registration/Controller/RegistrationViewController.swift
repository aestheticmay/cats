//
//  RegistrationViewController.swift
//  cats
//
//  Created by Майя Калицева on 15.10.2022.
//

import UIKit
import SnapKit

final class RegistrationViewController: UIViewController {
    
    // MARK: Private Properties
    
    private let tableView: UITableView = {
        let tbv = UITableView()
        tbv.backgroundColor = .white
        tbv.separatorStyle = .none
        tbv.tableFooterView = UIView()
        tbv.rowHeight = UITableView.automaticDimension
        tbv.bounces = false
        tbv.keyboardDismissMode = .onDrag
        tbv.delaysContentTouches = false
        tbv.register(RegistrationCell.self, forCellReuseIdentifier: "RegistrationCell")
        tbv.register(RegistrationCatCell.self, forCellReuseIdentifier: "RegistrationCatCell")
        tbv.register(RegistrationTextFields.self, forCellReuseIdentifier: "RegistrationTextFields")
        return tbv
    }()
    
    // MARK: Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        setupLayout()
    }

    // MARK: Private Methods
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: TableView delegate and datasource

extension RegistrationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath) as? RegistrationCell else { return UITableViewCell() }
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCatCell", for: indexPath) as? RegistrationCatCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationTextFields", for: indexPath) as? RegistrationTextFields else { return UITableViewCell() }
            return cell
        }
    }
}

