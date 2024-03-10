//
//  OnBoardingScannerInstance.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

public enum Language {
    case th
    case en
    
    var key: String {
        switch self {
        case .th: return "th"
        case .en: return "en"
        }
    }
}

public enum Theme {
    
    case LPA
    case HSA
    
    var spinnerFileName: String {
        switch self {
        case .LPA: return "livingplusSpinner"
        case .HSA: return "home"
        }
    }
}

public class OnBoardingScannerInstance {
    
    public static let shared = OnBoardingScannerInstance()
    
    private(set) var language: Language
    private(set) var theme: Theme
    
    public init() {
        language = .en
        theme = .HSA
    }
    
    public func setLanguage(_ lang: Language) {
        language = lang
    }
    
    public func setTheme(_ theme: Theme) {
        self.theme = theme
    }
}
