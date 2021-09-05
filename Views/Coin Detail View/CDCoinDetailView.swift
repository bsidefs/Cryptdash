//
//  CDCoinDetailView.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/25/21.
//

import SwiftUI

struct CDCoinDetailView: View {
    @ObservedObject var viewModel       = CDCoinDetailViewModel()
    
    @Binding var isShowingDetailView    : Bool
    let coin                            : CDCoin
    
    @State private var didDrawGraph     = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Spacer()
                .frame(height: 150)
            
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
            .frame(width: 50, height: 50)
            
            VStack(alignment: .center, spacing: 2) {
                Text(coin.name)
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(
                        Color(
                            UIColor(hex: coin.color, alpha: 1.0) ?? .label
                        )
                    )
                Text(coin.symbol)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
                .frame(height: 20)
            
            VStack {
                HStack(spacing: 0) {
                    VStack {
                        Text("Rank")
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    VStack {
                        Text("Price")
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    VStack {
                        Text("Market Cap")
                            .fontWeight(.medium)
                    }
                    .frame(maxWidth: .infinity)
                }
                .frame(height: 20)
                .font(.caption)
                .foregroundColor(.secondary)
                
                Divider()
                
                HStack(alignment: .top, spacing: 0) {
                    VStack {
                        Text("\(coin.rank)")
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                        Text(coin.formattedPrice)
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack {
                        Text(coin.formattedMarketCap)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            
            Spacer()
                .frame(height: 40)
            
            
            HStack {
                Text("Price Graph (24h)")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            
            VStack(spacing: 25) {
                CDSparklineView(sparkline: coin.sparkline.map { Double($0)! })
                    .frame(height: 150)
                
                Text(coin.formattedChange)
                    .foregroundColor(coin.percentChangeColor)
                    .padding(4)
                    .background(coin.percentChangeColor.opacity(0.2))
                    .cornerRadius(3.0)
                    .opacity(didDrawGraph ? 1 : 0)
            }
            .padding()
            
            Spacer()
                .frame(height: 40)
            
            Button {
                withAnimation { self.isShowingDetailView = false }
            } label: {
                Text("Close")
                    .foregroundColor(.primary)
                    .frame(width: UIScreen.main.bounds.width, height: 75)
                    .padding(.vertical, 20)
            }
        }
        //.frame(width: UIScreen.main.bounds.width)
        .background(CDVisualEffectView())
        .ignoresSafeArea()
        .onAppear {
            viewModel.fetchCoinIcon(from: coin.iconUrl)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.linear(duration: 0.5)) { self.didDrawGraph = true }
            }
        }
    }
}

// UIApplication.shared.windows[0].safeAreaInsets.top + 50

struct CDCoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CDCoinDetailView(isShowingDetailView: .constant(true),
                         coin: CDCoin(id: "1",
                                      name: "Bitcoin",
                                      symbol: "BTC",
                                      rank: 1,
                                      price: "$647.56",
                                      marketCap: "159393904304",
                                      change: "-3.45",
                                      sparkline: ["49003.00350076174816453529", "48943.40611987387100444124", "48961.86695144564443742281", "48975.37987324432005635649", "48955.32791594497108399065", "48896.23152173688139383741", "48761.76801187710992639687", "48852.98296956077582864653", "48741.31117777908421090669", "48592.18588375805204570651", "48681.82165261259812167872", "48995.03235836900231180825", "48997.32796482250128809429", "48941.16143990512155249899", "48634.08892720059296025367", "48660.55422355643147888033", "48804.28322654025396024809", "48869.74923874786611975379", "48766.12105043933758878477", "48938.74040588918679014319", "49445.91514327003669781841", "49303.78964908510500968843", "48608.76590858614871040621", "48164.11781210560261094375", "48230.66390605201982216151", "48335.09806548129209205246", "48424.16138177609069276045"],
                                      iconUrl: "https://cdn.coinranking.com/bOabBYkcX/bitcoin_btc.png",
                                      color: "#f7931A"))
            .preferredColorScheme(.dark)
    }
}
