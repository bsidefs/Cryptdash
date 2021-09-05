//
//  CDHalfSheetView.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/21/21.
//

import UIKit
import SwiftUI

// actually, this is intended for use on ios 15 where we can set detents.
// as such, this is incomplete due to our ios 14 target
struct CDHalfSheetView<SheetView: View>: UIViewControllerRepresentable {
    @Binding var isShowing  : Bool
    
    let content             : SheetView
    let title               : String
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController(nibName: nil, bundle: nil)
        controller.view.backgroundColor = .clear
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if isShowing {
            let sheetController = UIHostingController(rootView: content)
            sheetController.title = title
            let navController   = UINavigationController(rootViewController: sheetController)
            
            uiViewController.present(navController, animated: true) {
                DispatchQueue.main.async {
                    self.isShowing = false
                }
            }
        }
    }
}
