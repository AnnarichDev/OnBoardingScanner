//
//  Settings.swift
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

enum Theme {
    
    case LPA
    case HSA
    
    var spinnerFileName: String {
        switch self {
        case .LPA: return "livingplusSpinner"
        case .HSA: return "home"
        }
    }
}

public class Settings {
    
    public static let shared = Settings()
    
    private(set) var language: Language
    private(set) var environment: Environment
    var theme: Theme
    
    public init() {
        language = .en
        environment = .hsaDevelopment
        theme = environment == .lpaProduction || environment == .lpaDevelopment ? .LPA : .HSA
    }
    
    public func setLanguage(_ lang: Language) {
        language = lang
    }
    
    public func setEnvironment(_ env: Environment) {
        environment = env
        theme = environment == .lpaProduction || environment == .lpaDevelopment ? .LPA : .HSA
    }
}

public enum Environment {
    
    case hsaProduction
    case hsaDevelopment
    case lpaProduction
    case lpaDevelopment
}
