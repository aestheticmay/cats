//
//  FavoritesViewController.swift
//  cats
//
//  Created by Майя Калицева on 22.11.2022.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let tableView: UITableView = {
        let tbv = UITableView()
        tbv.backgroundColor = .clear
        tbv.separatorStyle = .none
        tbv.tableFooterView = UIView()
        tbv.rowHeight = UITableView.automaticDimension
        tbv.delaysContentTouches = false
        tbv.keyboardDismissMode = .onDrag
        tbv.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.identifier)
        return tbv
    }()
    
    private var catsModel = [CatModel]()
    
    // MARK: - Life-Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupLayout()
    }
    
    // MARK: - Private Methods
    
    func postRequest(id: String) {
        guard let endpoint = URLComponents(string: ApiClient.ApiClientEndpoint.favourites.urlString()) else { return }
        
        guard let url = endpoint.url else {
            return
        }
        let parameters: [String: Any] = ["id": id]

        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(ApiClient.Identifiers.apiKey, forHTTPHeaderField: "x-api-key")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }

        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode)
            else {
                print("Invalid Response received from the server")
                return
            }
            
            guard let responseData = data else {
                print("nil Data received from the server")
                return
            }
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                    print(jsonResponse)
                    // handle json response
                } else {
                    print("data maybe corrupted or in wrong format")
                    throw URLError(.badServerResponse)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupLayout() {
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
    
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        let cat = catsModel[indexPath.row]
        cell.setup(cat)
        return cell
    }
}
