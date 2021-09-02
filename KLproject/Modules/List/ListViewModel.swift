//
//  ListViewModel.swift
//  KLproject
//
//  Created by KL on 02/09/2021.
//

import Foundation

protocol ListViewModelProtocol {
    var cryptocurrencies: [Cryptocurrency] { get }
    var title: String { get }
    func fetchData(completion: @escaping (String?) -> ())
    func getPriceChange(atIndex index: Int) -> PriceChange
}

final class ListViewModel: ListViewModelProtocol {
    
    private let dataService: DataServiceProtocol
    
    var cryptocurrencies: [Cryptocurrency] = []
    var title: String {
        return "Cryptocurrencies (\(cryptocurrencies.count))"
    }
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    func fetchData(completion: @escaping (String?) -> ()) {
        dataService.fetchData() { [weak self] response in
            switch response {
            case .success(let data):
                self?.cryptocurrencies = data.data
                completion(nil)
            case .failure(let error):
                completion(error.rawValue)
            }
        }
    }
    
    func getPriceChange(atIndex index: Int) -> PriceChange {
        return .none
    }
}
