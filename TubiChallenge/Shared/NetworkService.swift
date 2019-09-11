//
//  NetworkManager.swift
//  TubiChallenge
//
//  Created by Matthew Pileggi on 9/9/19.
//  Copyright © 2019 Matthew Pileggi. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case emptyURL
    case notDecodable
    case responseError
}

class NetworkService {
    
    //Reusable network service code for retrieving items compatible with our Router and the Codable protocol
    
    static func request<T: Codable>(router: Router, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = router.url else {
            completion(.failure(NetworkError.emptyURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.responseError))
                return
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(NetworkError.notDecodable))
            }
        }.resume()
    }
    
}
