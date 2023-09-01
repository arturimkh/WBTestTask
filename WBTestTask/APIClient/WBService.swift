//
//  WBService.swift
//  WBTestTask
//
//  Created by Artur Imanbaev on 31.08.2023.
//

import Foundation
final class WBService{
    
    static let shared = WBService()
    
    private init(){}
    
    enum WBServiceError: Error{
        case failedToCreateRequest
        case failedToGetData
    }
    func execute<T: Codable>(
    _ request: WBRequest,
    expecting type:T.Type,
    completion: @escaping (Result<T,Error>) -> Void
    ){
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(WBServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? WBServiceError.failedToGetData))
                return
            }
            
            //Decode response
            do{
                let json = try JSONDecoder().decode(type.self, from: data)
                completion(.success(json))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func request(from wbRequest: WBRequest) -> URLRequest? {
        guard let url = wbRequest.url else {return nil}
        var request = URLRequest(url:url)
        request.httpMethod = wbRequest.httpMethod
        return request
    }
}
