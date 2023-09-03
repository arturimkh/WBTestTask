//
//  WBListRegionsCollectionViewCellViewModel.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 31.08.2023.
//

import Foundation
final class WBListRegionsCollectionViewCellViewModel{
    public let regionName:String
    private let regionImageUrl:URL?
    //MARK: - Init
    init(regionName:String,regionImageUrl:URL?){
        self.regionName = regionName
        self.regionImageUrl = regionImageUrl
    }
    
    /// fetching Image of Cell
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
