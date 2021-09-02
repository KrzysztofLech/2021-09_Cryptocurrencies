//
//  DataService.swift
//  KLproject
//
//  Created by KL on 02/09/2021.
//

import UIKit

protocol DataServiceProtocol {
    func fetchData(completion: @escaping (Result<Cryptocurrencies, ErrorResult>) -> ())
}

final class DataService: DataServiceProtocol {
    
    private enum Constants {
        static let endpoint = "https://api.coinlore.com/api/tickers/?limit=20"
    }
    
    private var downloadTask: URLSessionDownloadTask?
    
    func fetchData(completion: @escaping (Result<Cryptocurrencies, ErrorResult>) -> ()) {
        guard let url = URL(string: Constants.endpoint) else {
            completion(.failure(.url))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                if let err = error as? URLError, err.code == .notConnectedToInternet {
                    completion(.failure(.noInternet))
                } else {
                    completion(.failure(.network))
                }
                return
            }

            else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(.failure(.statusCode))
                return
            }

            guard let data = data else {
                completion(.failure(.other))
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(Cryptocurrencies.self, from: data)
                completion(.success(responseData))
            } catch {
                completion(.failure(.parse))
            }
        }.resume()
    }
}
