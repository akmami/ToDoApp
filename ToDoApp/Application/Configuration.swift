//
//  Configuration.swift
//  ToDoApp
//
//  Created by Aybek Can Kaya on 27.07.2021.
//

import Foundation
import UIKit

var KeyWindow : UIWindow {UIApplication.shared.windows.first(where: { $0.isKeyWindow })! }

//Roboto ["Roboto-Black", "Roboto-Regular", "Roboto-BlackItalic", "Roboto-Light", "Roboto-Medium", "Roboto-Bold"]
struct C {
    static var statusBarHeight: CGFloat { UIDevice.current.hasNotch ? 44 : 22 }
    static var navigationBarHeight: CGFloat = 64
    
    enum Font: String {
        case bold = "Roboto-Bold"
        case medium = "Roboto-Medium"
        case light = "Roboto-Light"
        case regular = "Roboto-Regular"
        
        func font(_ size: CGFloat) -> UIFont {
            return UIFont(name: self.rawValue, size: size)!
        }
    }
}
