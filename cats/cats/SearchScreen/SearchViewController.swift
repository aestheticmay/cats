//
//  SearchViewController.swift
//  cats
//
//  Created by Майя Калицева on 27.10.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var limit = 4
    private var isRefreshed = false
    
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
    
    private let collectionView = CategoryViewController()
    
    private var catsModel = [CatModel]()
    private let refreshControl = UIRefreshControl()
    
    private lazy var activityIndicator = LoadMoreActivityIndicator(scrollView: self.tableView, spacingFromLastCell: 10, spacingFromLastCellWhenLoadMoreActionStart: 60)
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        reloadData()
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    @objc func reloadData() {
        fetchData() { [weak self] result in
            switch result {
            case .success(let model):
                self?.catsModel = model
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self?.tableView.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    private func fetchData(pageLimit: Int = 4, completion: @escaping (Result<[CatModel], Error>) -> Void) {
        
        guard var endpoint = URLComponents(string: (ApiClient.ApiClientEndpoint.allCats.urlString())) else { return }
        
        var queryParameters: [String: String] = [:]
        queryParameters["limit"] = String(limit)
        queryParameters["size"] = "small"
        //  queryParameters["page"] = "1" TODO: Add pagination
        
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
                if error != nil {
                    print(error.debugDescription)
                    
                } else {
                    do {
                        let myData = try JSONDecoder().decode([CatModel].self, from: data!)
                        self.catsModel = myData
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
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
        
        view.addSubview(collectionView)
        view.addSubview(tableView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top).inset(-10)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).inset(10)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        activityIndicator.start {
            DispatchQueue.global(qos: .utility).async {
                sleep(1)
                self.isRefreshed = true
                self.limit = 0
                self.limit += 5
                self.fetchData(pageLimit: self.limit) { [weak self] result in
                    switch result {
                    case .success(let model):
                        self?.catsModel = model
                        self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    case .failure(let error):
                        print(error)
                    }
                }
                DispatchQueue.main.async { [weak self] in
                    self?.activityIndicator.stop()
                }
            }
        }
    }
}
