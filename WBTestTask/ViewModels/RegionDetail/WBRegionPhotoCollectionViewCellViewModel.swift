//
//  WBDetailPhotoCollectionViewCellViewModel.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 02.09.2023.
//

import Foundation

final class WBRegionPhotoCollectionViewCellViewModel{
    private let regionImageUrl:URL?
    //MARK: - Init
    
    init(regionImageUrl:URL?){
        self.regionImageUrl = regionImageUrl
    }
    
    /// Fetching Image 
    /// - Parameter completion: completion with 2 results, Data and Error
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void){
        //TODO: Сделать чтобы в image manager
        guard let url = regionImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
}
