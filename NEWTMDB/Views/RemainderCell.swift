//
//  remainderCell.swift
//  Remainder
//
//  Created by Dmitriy Stepanov on 12.09.2022.
//

import UIKit

class RemainderCell: UITableViewCell {
    
    static let identefire = "remainderCell"
    
    var titleLable : UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.text = "Some Lable"
        lable.font = .systemFont(ofSize: 22, weight: .medium)
     return lable
    }()
    
    var subtitleLable : UILabel = {
        let lable = UILabel()
        lable.numberOfLines = 0
        lable.text = "Some descriptionLable"
        lable.font = .systemFont(ofSize: 14, weight: .light)
     return lable
    }()
    
    var imageLable : UIImageView = {
        var image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.backgroundColor = .secondarySystemBackground
        image.contentMode = .scaleAspectFill
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(){
        contentView.addSubview(titleLable)
        contentView.addSubview(subtitleLable)
        contentView.addSubview(imageLable)
        
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        imageLable.translatesAutoresizingMaskIntoConstraints = false
        subtitleLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            imageLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            imageLable.topAnchor.constraint(equalTo: subtitleLable.topAnchor),
            imageLable.widthAnchor.constraint(equalToConstant: 120),
            imageLable.heightAnchor.constraint(equalToConstant: 80),

            titleLable.leadingAnchor.constraint(equalTo: imageLable.trailingAnchor, constant: 12),
            titleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            subtitleLable.leadingAnchor.constraint(equalTo: titleLable.leadingAnchor),
            subtitleLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            subtitleLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 12),
            subtitleLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

        ])
    }
    
    func configureData(with viewModel: TitleViewModel) {
        titleLable.text = viewModel.title
        subtitleLable.text = viewModel.overview
        guard let imageKey = viewModel.imageURL else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(imageKey)") else { return }

            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else {
                    return
                }

                viewModel.imageData = data
                print(data)
                DispatchQueue.main.async {
                    self?.imageLable.image = UIImage(data: data)
                    
                }
            }.resume()
            
        }
        
    

    
}
