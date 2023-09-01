//
//  WBListRegionsViewViewModel.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 31.08.2023.
//

import Foundation
import UIKit

protocol WBListRegionsViewViewModelDelegate: AnyObject{
    func didLoadInitialRegions()
    func didSelectRegion(_ region: WBBrandModel)
}

final class WBListRegionsViewViewModel: NSObject{

    weak var delegate: WBListRegionsViewViewModelDelegate?
    
    private var regions:[WBBrandModel] = [] {
        didSet{
            for region in regions {
                let viewModel = WBListRegionsCollectionViewCellViewModel(
                    regionName: region.title,
                    regionImageUrl: URL(string: region.thumbUrls[0])
                )
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [WBListRegionsCollectionViewCellViewModel] = []
    
    public func fetchRegions(){
        WBService.shared.execute(.listRegionsRequest, expecting: WBGetAllBrandsResponse.self) { [weak self] result in
            switch result {
            case .success(let data):
                let results = data.brands
                self?.regions = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialRegions() 
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
//MARK: реализация CollectionViewDelegate
extension WBListRegionsViewViewModel: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let region = regions[indexPath.row]
        delegate?.didSelectRegion(region)
    }
}
//MARK: реализация CollectionViewDelegate

extension WBListRegionsViewViewModel: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WBListRegionsCollectionViewCell.cellIdentfier, for: indexPath) as? WBListRegionsCollectionViewCell else {
            fatalError("unsupported cell")
        }
        
        cell.configure(with: cellViewModels[indexPath.row])
        
        return cell
    }
}

extension WBListRegionsViewViewModel: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width+25)
    }
}
