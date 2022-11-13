//
//  SearchViewController.swift
//  cats
//
//  Created by Майя Калицева on 27.10.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    enum TableSection: Int {
        case userList
        case loader
    }
    
    private var pageLimit = 0
    private var currentLastId: Int? = nil
    private var isNewDataLoading = false
    
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
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    func fetchData(limit: Int = 10, completion: @escaping (Result<[CatModel], Error>) -> Void) {
       
        guard var endpoint = URLComponents(string: (ApiClient.ApiClientEndpoint.allCats.urlString())) else { return }
        print(endpoint)
        
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
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
  
    
    private func fetch(completed: ((Bool) -> Void)? = nil) {
        fetchData() { [weak self] result in
            switch result {
            case .success(let model):
                // 5
                self?.catsModel.append(contentsOf: model)
                // assign last id for next fetch
                completed?(true)
            case .failure(let error):
                print(error.localizedDescription)
                // 6
                completed?(false)
            }
        }
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
    
    private func hideBottomLoader() {
        DispatchQueue.main.async {
            let lastListIndexPath = IndexPath(row: self.catsModel.count - 1, section: TableSection.userList.rawValue)
            self.tableView.scrollToRow(at: lastListIndexPath, at: .bottom, animated: true)
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
                self.pageLimit += 10
                self.fetchData(limit: self.pageLimit) { [weak self] result in
                    switch result {
                    case .success(let model):
                        self?.catsModel = model
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
