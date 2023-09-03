//
//  WBRequest.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 31.08.2023.
//

import Foundation
///Class that describes all sorts of request
final class WBRequest{
    
    private struct Constants{
        static let baseUrl = "https://vmeste.wildberries.ru/api/guide-service/v1"
    }
    private var endpoint: WBEndpoint
    
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        return string
    }
        
        public var url: URL? {
            return URL(string: urlString)
        }
        
        public let httpMethod = "GET"
        //MARK: - Init
        public init(endpoint: WBEndpoint) {
            self.endpoint = endpoint
        }
}

extension WBRequest{
    /// get all regions
    static let listRegionsRequest = WBRequest(endpoint: .getBrands)
}
