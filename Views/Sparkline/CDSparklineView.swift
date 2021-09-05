//
//  CDSparklineView.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 9/1/21.
//

import SwiftUI

struct CDSparklineView: View {
    let sparkline: [Double]
    
    let maxY: Double
    let minY: Double
    
    let color: Color
    
    @State private var percentLoaded : CGFloat = 0.0
    
    init(sparkline: [Double]) {
        self.sparkline = sparkline
        
        self.maxY = sparkline.max() ?? 0
        self.minY = sparkline.min() ?? 0
        
        let change = (sparkline.last ?? 1) - (sparkline.first ?? 1)
        self.color = change >= 0 ? Color.green : Color.red
    }
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                CDSparklineBackground(min: Double(minY),
                                      mid: Double((maxY + minY) / 2),
                                      max: Double(maxY))
                    .frame(width: 55)
                Divider()
                Path { path in
                    for index in sparkline.indices {
                        let xPosition = ((proxy.size.width - 55.0) / CGFloat(sparkline.count)) * (CGFloat(index + 1))
                        
                        let yAxisRange = maxY - minY
                        let yPosition = (1 - CGFloat((sparkline[index] - minY) / yAxisRange)) * proxy.size.height
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: xPosition, y: yPosition))
                        }
                        
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
                .trim(from: 0.0, to: percentLoaded)
                .stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .background(
                    VStack {
                        Spacer()
                        Divider()
                        Spacer()
                        Divider()
                    }
                )
            }
        }
        .onAppear {
            DispatchQueue.main.async {
                withAnimation(.linear(duration: 2.0)) {
                    self.percentLoaded = 1.0
                }
            }
        }
    }
}

struct CDSparklineView_Previews: PreviewProvider {
    static var previews: some View {
        CDSparklineView(sparkline: [49003.00350076174816453529,
                                    48943.40611987387100444124,
                                    48961.86695144564443742281,
                                    48975.37987324432005635649,
                                    48955.32791594497108399065,
                                    48896.23152173688139383741,
                                    48761.76801187710992639687,
                                    48852.98296956077582864653,
                                    48741.31117777908421090669,
                                    48592.18588375805204570651,
                                    48681.82165261259812167872,
                                    48995.03235836900231180825,
                                    48997.32796482250128809429,
                                    48941.16143990512155249899,
                                    48634.08892720059296025367,
                                    48660.55422355643147888033,
                                    48804.28322654025396024809,
                                    48869.74923874786611975379,
                                    48766.12105043933758878477,
                                    48938.74040588918679014319,
                                    49445.91514327003669781841,
                                    49303.78964908510500968843,
                                    48608.76590858614871040621,
                                    48164.11781210560261094375,
                                    48230.66390605201982216151,
                                    48335.09806548129209205246,
                                    48424.16138177609069276045])
            //.preferredColorScheme(.dark)
    }
}

struct CDSparklineBackground: View {
    let min: Double
    let mid: Double
    let max: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(max.formatUsingCurrencyAbbreviation())
            Spacer()
            
            Text(mid.formatUsingCurrencyAbbreviation())
            Spacer()
            
            Text(min.formatUsingCurrencyAbbreviation())
        }
        .font(.caption)
    }
}
