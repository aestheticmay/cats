//
//  CategoryViewController.swift
//  cats
//
//  Created by Майя Калицева on 23.11.2022.
//

import UIKit

final class CategoryTableViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let selectCategoryLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Please, select the category"
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Academy Engraved LET", size: 30)
        return lbl
    }()
    
    private let selectedBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemPink.withAlphaComponent(0.3)
        return view
    }()
    
    private let closeImageView: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "multiply")?.withTintColor(UIColor.black), for: .normal)
        btn.tintColor = UIColor.black
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(closeCategoriesList), for: .touchUpInside)
        return btn
    }()
    
    private let tableView: UITableView = {
        let tbv = UITableView(frame: .zero, style: .grouped)
        tbv.backgroundColor = UIColor.white
        tbv.separatorStyle = .none
        tbv.rowHeight = UITableView.automaticDimension
        tbv.delaysContentTouches = false
        tbv.keyboardDismissMode = .onDrag
        tbv.register(CategoryTableCell.self, forCellReuseIdentifier: CategoryTableCell.identifier)
        return tbv
    }()
    
    private var categoryModel = [CategoryModel]()
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchCategories()
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    @objc func closeCategoriesList() {
        print("tap")
        dismiss(animated: true)
    }
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchCategories() {
        guard let endpoint = URLComponents(string: ApiClient.ApiClientEndpoint.categories.urlString()) else { return }
        
        guard let url = endpoint.url else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(ApiClient.Identifiers.apiKey, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    print(error.debugDescription)
                    
                } else {
                    do {
                        let myData = try JSONDecoder().decode([CategoryModel].self, from: data!)
                        self.categoryModel = myData
                        self.tableView.reloadData()
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }

    private func setupLayout() {
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Academy Engraved LET", size: 25)!]
        title = "Random Cats"
        
        view.addSubview(selectCategoryLabel)
        view.addSubview(closeImageView)
        view.addSubview(tableView)
        
        selectCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(closeImageView.snp.bottom).inset(30)
            make.leading.equalToSuperview().inset(10)
           // make.bottom.equalTo(tableView.snp.top).inset(-5)
        }
        
        closeImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(3)
            make.trailing.equalToSuperview()
            make.bottom.equalTo(selectCategoryLabel.snp.top).inset(-30)
            make.width.height.equalTo(50)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(selectCategoryLabel.snp.bottom).inset(5)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
}

extension CategoryTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableCell.identifier, for: indexPath) as? CategoryTableCell else { return UITableViewCell() }
        let cat = categoryModel[indexPath.row]
        cell.selectedBackgroundView = selectedBackgroundView
        cell.setup(cat)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
    }
}

