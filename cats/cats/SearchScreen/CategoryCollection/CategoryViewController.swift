//
//  CategoryViewController.swift
//  cats
//
//  Created by Майя Калицева on 16.11.2022.
//

import UIKit

final class CategoryViewController: UIView {
    
    private var catsModel = [CategoryModel]()
    
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let cvc = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cvc.backgroundColor = .red
        cvc.showsHorizontalScrollIndicator = false
        cvc.register(CategoryCollectionCell.self, forCellWithReuseIdentifier: CategoryCollectionCell.identifier)
        return cvc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        fetchCategories { [weak self] result in
            switch result {
            case .success(let model):
                self?.catsModel = model
            case .failure(let error):
                print(error)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(categoryCollectionView)
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
    }
    
    private func fetchCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
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
                        self.catsModel = myData
                        self.categoryCollectionView.reloadData()
                    } catch let error {
                        print(error)
                    }
                }
            }
        }
        task.resume()
        
        
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catsModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.identifier, for: indexPath) as! CategoryCollectionCell
        let cat = catsModel[indexPath.row]
        cell.configure(model: [cat])
       // cell.configure(model: cat.categories)
        cell.backgroundColor = UIColor.yellow
        return cell
    }
    
    
}
