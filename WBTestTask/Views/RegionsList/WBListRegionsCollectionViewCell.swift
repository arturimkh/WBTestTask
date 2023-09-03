//
//  WBListRegionsCollectionViewCell.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 31.08.2023.
//

import UIKit

final class WBListRegionsCollectionViewCell: UICollectionViewCell {
    
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
    
    private let likedButton: WBLikedButtonView = {
       let button = WBLikedButtonView()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        addConstraints()
        setUpLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// adding constaints and adding subviews
    private func addConstraints(){
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(likedButton)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            likedButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            likedButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            likedButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            likedButton.rightAnchor.constraint(equalTo: contentView.rightAnchor)

        ])
    }
    
    @objc
    /// target of button
    private func didTapButton(){
        guard let labelText = nameLabel.text else {return}
        likedButton.switchButton(labelText: labelText)
    }
    
    /// cheking is liked or not
    public func isLiked(){
        guard let labelText = nameLabel.text else {return}
        likedButton.checkInfoAbout(labelText: labelText)
    }
    
    /// function before reusing imageView and label
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
    }
    
    /// function to work with darkMode
    /// - Parameter previousTraitCollection: previousTraitCollection
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setUpLayer()
    }
    
    /// setting layer of cell 
    private func setUpLayer(){
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowOffset = CGSize(width: -4, height: -4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    /// Configuring our cell
    /// - Parameter viewModel: single region view model cell
    public func configure(with viewModel: WBListRegionsCollectionViewCellViewModel){
        nameLabel.text = viewModel.regionName
        isLiked()
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
