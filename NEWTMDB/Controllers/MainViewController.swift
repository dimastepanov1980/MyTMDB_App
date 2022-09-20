//
//  ViewController.swift
//  Remainder_1
//
//  Created by Dmitriy Stepanov on 11.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    var remainderTable = UITableView()
    private var viewModels = [TitleViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
    }
    

    func configureTable() {
        view.addSubview(remainderTable)
        title = "Remainder Title"
        remainderTable.delegate = self
        remainderTable.dataSource = self
        remainderTable.register(RemainderCell.self, forCellReuseIdentifier: RemainderCell.identefire)
        remainderTable.translatesAutoresizingMaskIntoConstraints = false
        remainderTable.frame = view.bounds
        remainderTable.estimatedRowHeight = 88
        remainderTable.rowHeight = UITableView.automaticDimension
        
        API_Caller.shared.fetchData(type: TypeMovie.trendingMovies) { [weak self] result in
            switch result {
            case .success(let success):
                self?.viewModels = success.compactMap({
                    TitleViewModel(
                        id: $0.id,
                        original_language: $0.original_language ?? "",
                        overview: $0.overview ?? "No Description",
                        imageURL: $0.poster_path ?? "",
                        release_date: $0.release_date ?? "Comming Soon",
                        title: $0.title ?? "No title",
                        vote_average: $0.vote_average ?? 0,
                        vote_count: $0.vote_count ?? 0)
                })
                DispatchQueue.main.async {
                    self?.remainderTable.reloadData()
                }
                
            case.failure(let error):
                print(error)
            }
        }
    }
}


extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RemainderCell.identefire) as? RemainderCell else { return UITableViewCell() }
        cell.configureData(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = self.viewModels[indexPath.row]
        let detailVC = DetailViewController()
        guard let image = title.imageURL else {return}        
        detailVC.configureDetailViewData(with: DetailViewModel(nameDetailView: title.title ?? "No Title", descriptionDetailView: title.overview ?? "No description", imageURL: image))

        self.navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

/*
 UIViewController
 0. add var UITableView()
 1. add view.addSubview
 2. delegate, dataSource
 3. extension UITableViewDelegate UITableViewDataSource
 4. row hight (static, will try make it dynamic)
 5. register cell
 6. set constains
 
 UITableViewCell
 0. add some element lable, image etc
 1. add override init
 2. add contentView.addSubview
 3. add NSLayoutConstraint
 
 */
