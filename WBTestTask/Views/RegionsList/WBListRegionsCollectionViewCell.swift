//
//  WBListRegionsCollectionViewCell.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 31.08.2023.
//

import UIKit

class WBListRegionsCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentfier = "WBListRegionsCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        addConstraints()
        setUpLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints(){
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            

            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor,constant: -5),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),

        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    private func setUpLayer(){
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowOffset = CGSize(width: -4, height: -4)
        contentView.layer.shadowOpacity = 0.3
    }
    public func configure(with viewModel: WBListRegionsCollectionViewCellViewModel){
        nameLabel.text = viewModel.regionName
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                } 
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
