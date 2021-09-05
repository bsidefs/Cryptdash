//
//  CDCoinView.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/20/21.
//

import SwiftUI

struct CDCoinView: View {
    @StateObject var viewModel = CDCoinViewModel()
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    if viewModel.isLoading {
                        CDLoadingView()
                    }
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.coins) { coin in
                                CDCoinGridCellView(coin)
                                    .onTapGesture {
                                        viewModel.selectedCoin = coin
                                        withAnimation {
                                            viewModel.isShowingDetailView = true
                                        }
                                    }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .navigationTitle("Cryptocurrencies")
            }
            
            if viewModel.isShowingDetailView {
                CDCoinDetailView(isShowingDetailView: $viewModel.isShowingDetailView, coin: viewModel.selectedCoin!)
            }
        }
        .onAppear {
            viewModel.fetchCoins()
        }
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        CDCoinView()
            .preferredColorScheme(.dark)
    }
}
