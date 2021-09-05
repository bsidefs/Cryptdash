//
//  CDNetworkService.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/21/21.
//

import UIKit
import Combine

final class CDNetworkService {
    // MARK: - Properties
    static let shared           = CDNetworkService()
    
    private let baseEndpoint    = "https://api.coinranking.com/v2/coins/"
    private let apiKey          = "coinrankingabe7e4d4e2f22be5d37e114d5d289ff5a4a597f9747eb720"
    
    
    // MARK: - Init
    private init() {}
    
    
    // MARK: - Methods
    func fetchCoins() -> AnyPublisher<CDCoinResponseContainer,Error> {
        let url = URL(string: self.baseEndpoint)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-access-token")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { data, response in
                return data
            }
            .decode(type: CDCoinResponseContainer.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchCoinIcon(from iconUrl: String) -> AnyPublisher<UIImage?,URLError> {
        let url = URL(string: iconUrl)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                return UIImage(data: data)
            }
            .eraseToAnyPublisher()
    }
}
