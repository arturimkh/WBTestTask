//
//  WBRegionDetailViewViewModel.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 01.09.2023.
//

import Foundation
import UIKit

final class WBRegionDetailViewViewModel: NSObject{
    
    private let region: WBRegion
    
    public var title: String {
        region.title
    }
    public var viewsInfo: Int {
        region.viewsCount
    }
    private var requestUrls: [URL] {
        var urls:[URL] = []
        for urlString in region.thumbUrls {
            guard let url = URL(string: urlString) else {fatalError("No url")}
            urls.append(url)
        }
        return urls
    }
    //MARK: - Init
    init(region: WBRegion) {
        self.region = region
    }
    
    /// creating compositional layout section
    /// - Returns: NSCollectionLayoutSection
    public func createImageGalerySection() -> NSCollectionLayoutSection{

        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.95),
                heightDimension: .absolute(250)
            ),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
//MARK: CollectionViewDataSource
extension WBRegionDetailViewViewModel: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return region.thumbUrls.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WBRegionPhotoCollectionViewCell.cellIdentfier, for: indexPath) as? WBRegionPhotoCollectionViewCell else {
            fatalError("unsupported cell")
        }
        let requestUrl = requestUrls[indexPath.row]
        let viewModel = WBRegionPhotoCollectionViewCellViewModel(regionImageUrl: requestUrl)
        cell.configure(with: viewModel)
        return cell
    }
}

