//
//  LoaderView.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

final class LoaderView: BaseUIView {
    
    let imageView = UIImageView()
    let animation = CABasicAnimation(keyPath: "transform")
    
    override func buildUI() {
        super.buildUI()
        let iconImage = UIImage()
        let tintedImage = iconImage.withRenderingMode(.alwaysTemplate)
        imageView.image = tintedImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        animation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(.pi / 2.0, 0.0, 0.0, 1.0))
        animation.duration = 0.25
        animation.isCumulative = true
        animation.repeatCount = MAXFLOAT
        imageView.layer.add(animation, forKey: "loading_animation")
    }
    
    func showLoading() {
        imageView.setHiddenFaded(false, delay: 0)
    }
    
    func hideLoading() {
        imageView.setHidden(true, fading: true, delay: 0, removeFromSuperview: false)
    }
    
    func startLoading() {
        imageView.removeFromSuperview()
        guard let topView = UIApplication.topWindow.rootViewController?.view.subviews.last else { return }
        topView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(50.0)
            $0.center.equalToSuperview()
        }
        imageView.layer.add(animation, forKey: "loading_animation")
    }
    
    func stopLoading() {
        imageView.removeFromSuperview()
    }
}
