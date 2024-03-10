//
//  UIApplication+Extension.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

extension UIApplication {

    static var topWindow: UIWindow {
        if #available(iOS 15.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            return windowScene!.windows.first!
        }
        return UIApplication.shared.windows.filter { $0.isKeyWindow }.first!
    }
}
