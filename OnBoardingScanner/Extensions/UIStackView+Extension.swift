//
//  UIStackView+Extension.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

extension UIStackView {
   
   // Credit: https://gist.github.com/Deub27/5eadbf1b77ce28abd9b630eadb95c1e2
   func removeAllArrangedSubviews() {
      let removedSubviews = arrangedSubviews.reduce([]) { allSubviews, subview -> [UIView] in
         self.removeArrangedSubview(subview)
         return allSubviews + [subview]
      }
      
      // Deactivate all constraints
      NSLayoutConstraint.deactivate(removedSubviews.flatMap { $0.constraints })
      
      // Remove the views from self
      removedSubviews.forEach { $0.removeFromSuperview() }
   }
   
   func addArrangedSubviews(_ views: UIView...) {
      views.forEach(addArrangedSubview)
   }
}
