//
//  CDCoinViewModel.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/21/21.
//

import SwiftUI
import Combine

final class CDCoinViewModel: ObservableObject {
    // MARK: - Properties
    @Published var coins                        = [CDCoin]()
    @Published var coinIcon                     : Image?
    
    @Published var selectedCoin                 : CDCoin?
    
    @Published var isLoading                    = false
    
    @Published var isShowingDetailView          = false
    @Published var isShowingSortingOptionsSheet = false
    
    private var cancellable                     : AnyCancellable?
    
    
    // MARK: - Methods
    func fetchCoins() {
        isLoading = true
        self.cancellable = CDNetworkService.shared.fetchCoins()
            .sink { completion in
                print("completed fetching coins with result: \(completion)")
            } receiveValue: { [weak self] coinResponseContainer in
                guard let self = self else { return }
                
                self.coins = coinResponseContainer.data.coins
                self.isLoading = false
            }
    }
}
