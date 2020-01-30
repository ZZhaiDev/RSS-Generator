//
//  NetworkLayer.swift
//  RSS-Generator
//
//  Created by zijia on 1/29/20.
//  Copyright © 2020 zijia. All rights reserved.
//

import UIKit

enum ServiceError: Error {
    case invalidData
}

enum Result<T> {
    case success(T)
    case error(Error)
}

class NetworkLayer {
    
    static let shareInstance = NetworkLayer()
    let service = Service()
    
    func getRSSData(str: String, completion: @escaping (Result<[RSSResult]>) -> Void) {
        service.makeApiCall(str: str) { (result) in
            switch result {
            case .success(let data):
                do {
                    let dataSource: RSSModel = try JSONDecoder().decode(RSSModel.self, from: data)
                    let results = dataSource.feed.results
                    DispatchQueue.main.async {
                        completion(.success(results))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completion(.error(error))
                    }
                }
            case .error(let err):
                DispatchQueue.main.async {
                    completion(.error(err))
                }
            }
        }
    }
    
}

class Service{
    
    func makeApiCall(str: String, completion: @escaping (Result<Data>) -> Void) {
        
        guard let url = URL(string: str) else {
            completion(.error(ServiceError.invalidData))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.error(error))
                return
            }
            guard let data = data else {
                completion(.error(ServiceError.invalidData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
