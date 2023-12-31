//
//  WBRegionDetailView.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 01.09.2023.
//

import UIKit

/// View for single region
final class WBRegionDetailView: UIView {
    
    public var viewModel: WBRegionDetailViewViewModel

    private var collectionView: UICollectionView?
                
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Количество просмотров: "
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20,weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let likedButton: WBLikedButtonView = {
       let button = WBLikedButtonView()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    /// - Parameters:
    ///   - frame: frame of view
    ///   - viewModel: ViewModel of Detail region
    init(frame: CGRect, viewModel: WBRegionDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        isLiked()
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        
        addSubview(spinner)
        addSubview(collectionView)
        addSubview(viewsLabel)
        addSubview(likedButton)
        
        addConstraints()
        setUpCollectionView()
        setLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    /// target of button
    private func didTapButton(){
        likedButton.switchButton(labelText: viewModel.title)
    }
    
    /// cheking is liked or not
    public func isLiked(){
        likedButton.checkInfoAbout(labelText: viewModel.title)
    }

    
    /// setting labels
    private func setLabel(){
        guard let currentText = viewsLabel.text else {return}
        viewsLabel.text = currentText + String(viewModel.viewsInfo)
    }
    
    /// setting collectionView data source
    private func setUpCollectionView(){
        guard let collectionView = collectionView else {return}
        collectionView.dataSource = viewModel
    }
    
    /// adding constraints
    private func addConstraints(){
        guard let collectionView = collectionView else {return}
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.rightAnchor.constraint(equalTo:rightAnchor),
            collectionView.leftAnchor.constraint(equalTo:leftAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 250),
            
            viewsLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor,constant: 10),
            viewsLabel.leftAnchor.constraint(equalTo: leftAnchor),
            viewsLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            likedButton.topAnchor.constraint(equalTo: viewsLabel.bottomAnchor,constant: 20),
            likedButton.leftAnchor.constraint(equalTo: leftAnchor,constant: 30),
            likedButton.rightAnchor.constraint(equalTo: rightAnchor,constant: -30),
            likedButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
    
    /// creating CollectionView with compositional Layout
    /// - Returns: UICollectionView
    private func createCollectionView() -> UICollectionView{
        let layout = UICollectionViewCompositionalLayout { [weak self] _, _ in
            return self?.viewModel.createImageGalerySection()
        }
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WBRegionPhotoCollectionViewCell.self, forCellWithReuseIdentifier: WBRegionPhotoCollectionViewCell.cellIdentfier)
        return collectionView
    }



}
