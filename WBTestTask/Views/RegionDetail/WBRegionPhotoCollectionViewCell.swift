//
//  WBDetailPhotoCollectionViewCell.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 02.09.2023.
//

import UIKit

final class WBRegionPhotoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentfier = "WBRegionPhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addConstraints(){
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    public func configure(with viewModel: WBRegionPhotoCollectionViewCellViewModel){
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
