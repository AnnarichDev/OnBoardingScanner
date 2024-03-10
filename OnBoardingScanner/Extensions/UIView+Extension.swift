//
//  UIView+Extension.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        for view in subviews {
            self.addSubview(view)
        }
    }
    
    func clearSubViews() {
        guard !self.subviews.isEmpty else { return }
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    func setHidden(_ hidden: Bool, fading: Bool, delay: TimeInterval, removeFromSuperview remove: Bool) {
        if self.isHidden && hidden == false {
            self.alpha = 0.0
            self.isHidden = false
        }
        
        let duration: TimeInterval = fading ? 0.2 : 0.0
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions(), animations: {
            self.alpha = hidden ? 0.0 : 1.0
        }, completion: {finished in
            self.isHidden = hidden
            if remove {
                self.removeFromSuperview()
            }
        })
    }
    
    func setHiddenFaded(_ hidden: Bool, delay: TimeInterval) {
        setHidden(hidden, fading: true, delay: delay, removeFromSuperview: false)
    }
    
}
