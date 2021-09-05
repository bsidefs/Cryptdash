//
//  UIColor+Ext.swift
//  Cryptdash
//
//  Created by Brian Tamsing on 8/21/21.
//

import UIKit

extension UIColor {
    convenience init?(hex: String?, alpha: CGFloat) {
        guard let hex = hex else {
            return nil
        }
        
        let r, g, b: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(after: hex.startIndex)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                
                var hexNumber: UInt64 = 0
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255
                    
                    /* NOTE: unless we create a custom app color scheme where our background is not pure black,
                        we'll just need all black coin colors to default to Color.label, so return nil here to have that happen @ the call site.
                     */
                    if r == 0 && g == 0 && b == 0 {
                        return nil
                    }
                    
                    self.init(red: r, green: g, blue: b, alpha: alpha)
                    return
                }
            }
        }
        
        return nil
    }
}
