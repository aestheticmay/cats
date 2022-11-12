//
//  SearchViewController.swift
//  cats
//
//  Created by Майя Калицева on 27.10.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let tableView: UITableView = {
        let tbv = UITableView()
        tbv.backgroundColor = .clear
        tbv.separatorStyle = .none
        tbv.tableFooterView = UIView()
        tbv.rowHeight = UITableView.automaticDimension
        tbv.delaysContentTouches = false
        tbv.keyboardDismissMode = .onDrag
        tbv.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        return tbv
    }()
    
    private var catsModel = [CatModel]()
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchData(refresh: true)
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    @objc func reloadData() {
      fetchData(refresh: true)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    func fetchData(refresh: Bool = false) {
        
        if refresh {
            self.tableView.refreshControl?.beginRefreshing()
        }

        guard var endpoint = URLComponents(string: (ApiClient.ApiClientEndpoint.allCats.urlString())) else { return }
        print(endpoint)
        
        var queryParameters: [String: String] = [:]
        queryParameters["limit"] = "5"
        queryParameters["size"] = "small"

        endpoint.queryItems = queryParameters.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })

        guard let url = endpoint.url else {
            return
        }
       
        var request = URLRequest(url: url)
        request.setValue(ApiClient.Identifiers.apiKey, forHTTPHeaderField: "x-api-key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if refresh {
                    self.tableView.refreshControl?.endRefreshing()
                }
                
                if error != nil {
                    print(error.debugDescription)
                    
                } else {
                    do {
                        let myData = try JSONDecoder().decode([CatModel].self, from: data!)
                        self.catsModel = myData
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
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        let cat = catsModel[indexPath.row]
        cell.setup(cat)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = DetailsViewController(cats: catsModel[indexPath.row])
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
   /*
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == catsModel.count - 1 {
            reloadData()
            
        }
    
        */
}
