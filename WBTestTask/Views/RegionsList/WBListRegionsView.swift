//
//  WBListRegionsView.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 31.08.2023.
//

import UIKit


protocol WBListRegionsViewDelegate: AnyObject{
    func wbListRegionsView(
        _ listRegionsView: WBListRegionsView,
        didSelectRegion region: WBRegion
    )
}
class WBListRegionsView: UIView {
    
    weak var delegate: WBListRegionsViewDelegate?
    
    private let viewModel = WBListRegionsViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.register(WBListRegionsCollectionViewCell.self, forCellWithReuseIdentifier: WBListRegionsCollectionViewCell.cellIdentfier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addConstraints()
        viewModel.fetchRegions()
        viewModel.delegate = self
        setUpCollectionView()
        spinner.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addConstraints(){
        addSubview(collectionView)
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.rightAnchor.constraint(equalTo:rightAnchor),
            collectionView.leftAnchor.constraint(equalTo:leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    private func setUpCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
}
extension WBListRegionsView: WBListRegionsViewViewModelDelegate{
    
    /// after selection of single region, went to detail screen
    /// - Parameter region: Model of region
    func didSelectRegion(_ region: WBRegion) {
        delegate?.wbListRegionsView(self, didSelectRegion: region)
    }
    ///function to stop spinner and show regions
    func didLoadInitialRegions() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
}
