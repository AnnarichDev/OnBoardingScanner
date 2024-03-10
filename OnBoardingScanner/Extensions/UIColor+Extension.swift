//
//  UIColor+Extension.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

import UIKit

extension UIColor {
    
    // MARK: - Private
    private static let theme: Theme = OnBoardingScannerInstance.shared.theme
    
    public static let blackColor = UIColor(hexString: "#000000")
    
    public static let primaryColor: UIColor = {
        switch theme {
        case .LPA: return .blackColor
        case .HSA: return UIColor(hexString: "#022555")
        }
    }()
    
    public static let secondaryColor: UIColor = {
        switch theme {
        case .LPA: return UIColor(hexString: "#E6A500")
        case .HSA: return UIColor(hexString: "#0163E0")
        }
    }()
    
    /// Dusty Gray hex: #9B9B9B
    public static let dustyGrayColor = UIColor(hexString: "#9B9B9B")
    
    /// Border hex: #E6E6E6
    public static let borderColor = UIColor(hexString: "#E6E6E6")
    
    /// White Smoke hex: #F8F8F8
    public static let whiteSmokeColor = UIColor(hexString: "#F8F8F8")
        
    /// Disable Color hex: #acacac
    public static let disableColor = UIColor(hexString: "#acacac")
    
    /// Secondary Color Alpha 0.2
    public static let disableSecondaryColor = secondaryColor.withAlphaComponent(0.2)
    
    /// Medium Gray Color hex: #808080
    public static let mediumGrayColor = UIColor(hexString: "#808080")
    
    /// Light Gray Color hex: #F0F0F0
    public static let lightGrayColor = UIColor(hexString: "#F0F0F0")
    
    /// Text Title Color
    public static let textTitleColor: UIColor = {
        switch theme {
        case .LPA: return .blackColor
        case .HSA: return .secondaryColor
        }
    }()
    
    /// Link Color hex: #0163E0
    public static let linkColor = UIColor(hexString: "#0163E0")
    
    public static let darkGrayColor = UIColor.darkGray
    
    public static let darkTransparent = darkGrayColor.withAlphaComponent(0.6)
    
    public static let AlphaBallotColor: UIColor = {
        switch theme {
        case .LPA: return .secondaryColor.withAlphaComponent(0.2) //UIColor(hexString: "#E6A500", alpha: 0.2)
        case .HSA: return UIColor(hexString: "#ECF4FF")
        }
    }()
    
    public static let bgPrgressBarNotPass = UIColor(hexString: "#BBBBBB")
    public static let bgProgressBar = UIColor(hexString: "#EBEBEB")
    public static let progressBarTint: UIColor = {
        switch theme {
        case .LPA: return .secondaryColor.withAlphaComponent(0.2)
        case .HSA: return UIColor(hexString: "#A9CFFF")
        }
    }()
    
    static let BGLightGrayColor = UIColor(hexString: "#F4F3F4")
    static let RedPrimaryColor = UIColor(hexString: "#D7494A")
    public static let textButtonColor = UIColor(hexString: "#FFFFFF")
    public static let whiteColor = UIColor(hexString: "#FFFFFF")
    var hexString: String? {
        if let components = self.cgColor.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            return  String(format: "#%02x%02x%02x", (Int)(r * 255), (Int)(g * 255), (Int)(b * 255))
        }
        return nil
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        if hexFormatted.count == 6 {
            self.init(red: 0,
                      green: 0,
                      blue: 0,
                      alpha: alpha)
        }
        
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
