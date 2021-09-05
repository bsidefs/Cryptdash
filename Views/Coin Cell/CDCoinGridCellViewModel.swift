//
//  CDCoinGridCellViewModel.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/21/21.
//

import SwiftUI
import Combine

final class CDCoinGridCellViewModel: ObservableObject {
    @Published var coinIcon         : Image?
    @Published var isLoadingIcon    = false
    
    private var cancellable         : AnyCancellable?
    
    func fetchCoinIcon(from iconUrl: String) {
        isLoadingIcon = true
        self.cancellable = CDImageService.shared.fetchCoinIcon(from: iconUrl)
            .sink { completion in
                print("completed fetching coin icon with result: \(completion)")
            } receiveValue: { [weak self] image in
                guard let self = self else { return }
                
                if let image = image {
                    self.coinIcon = Image(uiImage: image)
                }
                self.isLoadingIcon = false
            }
    }
}
