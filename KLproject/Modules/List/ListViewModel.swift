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
    private var previousData: [Cryptocurrency] = []
    
    var cryptocurrencies: [Cryptocurrency] = []
    var title: String {
        return "Cryptocurrencies (\(cryptocurrencies.count))"
    }
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    func fetchData(completion: @escaping (String?) -> ()) {
        dataService.fetchData() { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case .success(let data):
                self.previousData = self.cryptocurrencies
                self.cryptocurrencies = data.data
                completion(nil)
            case .failure(let error):
                completion(error.rawValue)
            }
        }
    }
    
    func getPriceChange(atIndex index: Int) -> PriceChange {
        let currency = cryptocurrencies[index]
        guard let previousCurrency = previousData.first(where: { $0.id == currency.id }),
              let previousCurrencyPrice = Double(previousCurrency.price),
              let currencyPrice = Double(currency.price)
        else { return .none }
        
        switch currencyPrice - previousCurrencyPrice {
        case 0: return .none
        case ..<0: return .down
        default: return .up
        }
    }
}
