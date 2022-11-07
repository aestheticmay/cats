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
        tbv.backgroundColor = .white
        tbv.separatorStyle = .none
        tbv.tableFooterView = UIView()
        tbv.rowHeight = UITableView.automaticDimension
        tbv.bounces = false
        tbv.keyboardDismissMode = .onDrag
        tbv.delaysContentTouches = false
        tbv.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        return tbv
    }()
    
    private var cats: [CatModel] = []
    private var catsModel = [CatModel]()
    private let page = 0
    private let pageLimit = 10
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupLayout()
        loadCats()
    }
    
    // MARK: - Private Methods
    
    private func getCats(completion: @escaping (Result<[CatModel], Error>) -> Void) {
        guard var components = URLComponents(string: ApiClient.ApiClientEndpoint.allCats.urlString()) else { return }
        
        var queryParameters: [String: String] = [:]
        queryParameters["limit"] = "20"
        queryParameters["size"] = "small"
        
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
                actualSelf.cats = actualCats
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
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        let cat = cats[indexPath.row]
        cell.setup(cat)
        cell.catImageView.image = nil
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsViewController = DetailsViewController(cats: cats[indexPath.row])
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}
