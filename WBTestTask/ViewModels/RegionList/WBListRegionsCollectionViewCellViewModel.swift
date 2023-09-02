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
    init(regionName:String,regionImageUrl:URL?){
        self.regionName = regionName
        self.regionImageUrl = regionImageUrl
    }
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void){
        //TODO: Сделать чтобы в image manager
        guard let url = regionImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
}
