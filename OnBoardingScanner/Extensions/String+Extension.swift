//
//  String+Extension.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 1/3/2567 BE.
//

extension String {
    
    func regexSpecailCharacter() -> Bool{
        let regex  = ".*[^A-Za-z0-9].*"
        let textRegex = NSPredicate(format:"SELF MATCHES %@", regex)
        let regexResult = textRegex.evaluate(with: self)
        
        return regexResult
    }
    
    func localized() -> String {
        let currentLang = Settings.shared.language.key
        print("LLOG: pathResource", Bundle(for: QRScannerViewController.self).path(forResource: currentLang, ofType: "lproj"))
        guard let pathResource = Bundle(for: QRScannerViewController.self).path(forResource: currentLang, ofType: "lproj"),
              let bundle = Bundle(path: pathResource) else { return self }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
