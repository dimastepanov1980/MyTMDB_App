//
//  DetailViewController.swift
//  Remainder
//
//  Created by Dima Stepanov on 9/19/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel : DetailViewModel? = nil
    
    private let nameLable : UILabel = {
       let lable = UILabel()
        lable.font = .systemFont(ofSize: 28, weight: .medium)
        lable.numberOfLines = 0
        lable.text = "SomeName"
        return lable
    }()
    
    private let descriptionLable : UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 18, weight: .light)
         lable.numberOfLines = 0
         lable.text = "SomeDescription"
         return lable
    }()
    
    private let heroImageView : UIImageView = {
       let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureDetailView()
    }
    
    func configureDetailView(){
        view.addSubview(nameLable)
        view.addSubview(descriptionLable)
        view.addSubview(heroImageView)
        
        nameLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        heroImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heroImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            heroImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            heroImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: 300),

            nameLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLable.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 20),
            
            descriptionLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLable.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 5)
        ])
    }
    
    func configureDetailViewData(with model: DetailViewModel) {
        nameLable.text = model.nameDetailView
        descriptionLable.text = model.descriptionDetailView
        
        let imageKey = model.imageURL
        
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageKey)") else { return }
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                self?.viewModel?.imageData = data
                DispatchQueue.main.async {
                    self?.heroImageView.image = UIImage(data: data)
                }
            }.resume()
    }
}


