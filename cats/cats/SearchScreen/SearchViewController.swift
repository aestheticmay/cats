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
    private let pageLimit = 10
    private var page = String(1)
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupLayout()
        loadCats()
    }
    
    // MARK: - Private Methods
    
    @objc func reloadData() {
        loadCats()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    private func getCats(completion: @escaping (Result<[CatModel], Error>) -> Void) {
        guard var components = URLComponents(string: ApiClient.ApiClientEndpoint.allCats.urlString()) else { return }
        
        var queryParameters: [String: String] = [:]
        queryParameters["limit"] = "5"
        queryParameters["page"] = page
        
        components.queryItems = queryParameters.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })
        
        guard let url = components.url else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue(ApiClient.Identifiers.apiKey, forHTTPHeaderField: "x-api-key")
        
        var dataTask: URLSessionDataTask?
        let urlSession = URLSession.shared
        
        dataTask = urlSession.dataTask(with: request) { (data, _, error) in
            if let actualError = error {
                completion(.failure(actualError))
                return
            }
            
            if let actualData = data {
                do {
                    let decoder = JSONDecoder()
                    let cats = try decoder.decode([CatModel].self, from: actualData)
                    completion(.success(cats))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        
        dataTask?.resume()
    }

    func fetchCats(completion: @escaping ([CatModel]?) -> Void) {
        getCats(completion: { result in
            switch result {
            case .success(let result):
                completion(result)
            case .failure(_):
                completion(nil)
            }
        })
    }
    
    private func loadCats(breedsIds: [String] = [], completion: (() -> Void)? = nil) {
        
        fetchCats(completion: { [weak self] cats in
            guard let actualSelf = self else {
                return
            }
            if let actualCats = cats {
                tableView.refreshControl?.endRefreshing()
                actualSelf.catsModel = actualCats
                DispatchQueue.main.async {
                    completion?()
                    actualSelf.tableView.reloadData()
                }
            }
        })
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
