//
//  CDCoinGridCellView.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/21/21.
//

import SwiftUI
import Combine

struct CDCoinGridCellView: View {
    @StateObject var viewModel  = CDCoinGridCellViewModel()
    let coin                    : CDCoin
    
    init(_ coin: CDCoin) {
        self.coin = coin
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                ZStack {
                    if viewModel.isLoadingIcon {
                        CDLoadingView()
                    }
                    if let icon = viewModel.coinIcon {
                        icon
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .frame(width: 35, height: 35)
                
                VStack(alignment: .leading, spacing: 1) {
                    Text(coin.name)
                        .font(.headline)
                        .foregroundColor(
                            Color(
                                UIColor(hex: coin.color, alpha: 1.0) ?? .label
                            )
                        )
                        .multilineTextAlignment(.leading)
                    Text(coin.symbol)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(coin.formattedPrice)
                        .font(.headline)
                    Text(coin.formattedChange)
                        .font(.subheadline)
                        .foregroundColor(coin.percentChangeColor)
                        .padding(4)
                        .background(coin.percentChangeColor.opacity(0.2))
                        .cornerRadius(3.0)
                }
                Spacer()
            }
        }
        .padding()
        .frame(height: 155)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(5.0)
        .shadow(color: Color.primary.opacity(0.15), radius: 5, y: 2.5)
        .onAppear {
            viewModel.fetchCoinIcon(from: self.coin.iconUrl)
        }
    }
}

struct CoinListCellView_Previews: PreviewProvider {
    static var previews: some View {
        CDCoinGridCellView(CDCoin(id: "1",
                                  name: "Bitcoin",
                                  symbol: "BTC",
                                  rank: 1,
                                  price: "$647.56",
                                  marketCap: "5.5 billion",
                                  change: "+3.45",
                                  sparkline: [
                                    "9515.0454185372",
                                    "9540.1812284677",
                                    "9554.2212643043",
                                    "9593.571539283",
                                    "9592.8596962985",
                                    "9562.5310295967",
                                    "9556.7860427046",
                                    "9388.823394515",
                                    "9335.3004209165",
                                    "9329.4331700521",
                                    "9370.9993109108"
                                  ],
                                  iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.png",
                                  color: nil))
    }
}
