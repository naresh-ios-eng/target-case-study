//
//  Copyright © 2022 Target. All rights reserved.
//
import UIKit


enum AppFont {
    /// For each font family in the app we can create corresponding enum.
    enum SFPro {
        /// This will create a font with regular face and the size we can pass at runtime.
        case regular(CGFloat)
        /// This will create a font with bold face and the size we can pass at runtime.
        case bold(CGFloat)
        /// This will create a font with medium face and the size we can pass at runtime.
        case medium(CGFloat)
        
        var font: UIFont {
            switch self {
            case .bold(let size):
                UIFont(name: "SFPro-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
            case .regular(let size):
                UIFont(name: "SFPro-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
            case .medium(let size):
                UIFont(name: "SFPro-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
            }
        }
    }
}
