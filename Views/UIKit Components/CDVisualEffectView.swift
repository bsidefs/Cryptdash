//
//  CDVisualEffectView.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/27/21.
//

import UIKit
import SwiftUI

struct CDVisualEffectView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        
        return visualEffectView
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        // ...
    }
}
