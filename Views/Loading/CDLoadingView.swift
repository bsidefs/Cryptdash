//
//  CDLoadingView.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/21/21.
//

import SwiftUI

struct CDLoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .primary))
    }
}

struct CDProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CDLoadingView()
            .preferredColorScheme(.dark)
    }
}
