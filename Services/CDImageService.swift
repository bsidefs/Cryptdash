//
//  CDImageService.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/21/21.
//

import UIKit
import Combine

final class CDImageService {
    // MARK: - Properties
    static let shared       = CDImageService()
    
    
    // MARK: - Init
    private init() { }
    
    
    // MARK: - Methods
    func fetchCoinIcon(from iconUrl: String) -> AnyPublisher<UIImage?,URLError> {
        // iconUrls end in .svg by default, so change to the alternative .png format
        let pngUrl = iconUrl.replacingOccurrences(of: ".svg", with: ".png")
        
        let url = URL(string: pngUrl)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                return UIImage(data: data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
