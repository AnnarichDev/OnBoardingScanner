//
//  UIFontHelper.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 29/2/2567 BE.
//

extension UIFont {
    
    enum Graphik: String {
        
        case bold = "GraphikTH-SemiBold"
        case regular = "GraphikTH-Regular"
    }
    
    public class func graphik(ofSize size: CGFloat, weight: UIFont.Weight = .light, isItalic: Bool = false) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        
        switch weight {
        case .regular:
            let name = Graphik.regular
            return UIFont(name: name.rawValue, size: size) ?? systemFont
        case .bold:
            let name = Graphik.bold
            return UIFont(name: name.rawValue, size: size) ?? systemFont
        default:
            return systemFont
        }
    }
    
    public class func graphikRegular(ofSize size: CGFloat) -> UIFont {
        return graphik(ofSize: size, weight: .regular)
    }
    
    public class func graphikBold(ofSize size: CGFloat) -> UIFont {
        return graphik(ofSize: size, weight: .bold)
    }
    
    private static func registerFont(withName name: String, fileExtension: String) {
        let frameworkBundle = Bundle(for: OnBoardingScannerViewController.self)
        let pathForResourceString = frameworkBundle.path(forResource: name, ofType: fileExtension)
        let fontData = NSData(contentsOfFile: pathForResourceString!)
        let dataProvider = CGDataProvider(data: fontData!)
        let fontRef = CGFont(dataProvider!)
        var errorRef: Unmanaged<CFError>? = nil
        
        if (CTFontManagerRegisterGraphicsFont(fontRef!, &errorRef) == false) {
            print("Error registering font")
        }
    }
    
    public static func loadFonts() {
        registerFont(withName: Graphik.bold.rawValue, fileExtension: "ttf")
        registerFont(withName: Graphik.regular.rawValue, fileExtension: "ttf")
    }
}

public enum OnBoardingScannerFont {
    
    /// Graphik - Regular  Size  16
    static let text = UIFont.graphikRegular(ofSize: 16)
    /// Graphik - Bold  Size  16
    static let textBold = UIFont.graphikBold(ofSize: 16)
    /// Graphik - Bold  Size  18
    static let title = UIFont.graphikBold(ofSize: 18)
}
