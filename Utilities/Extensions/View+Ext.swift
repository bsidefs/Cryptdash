//
//  View+Ext.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/21/21.
//

import SwiftUI

extension View {
    func halfSheet<SheetView: View>(isShowing: Binding<Bool>, title: String, @ViewBuilder sheetView: @escaping () -> SheetView) -> some View {
        return self
            .background(
                CDHalfSheetView(isShowing: isShowing, content: sheetView(), title: title)
            )
    }
}
