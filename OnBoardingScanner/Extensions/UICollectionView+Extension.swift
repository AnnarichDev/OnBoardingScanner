//
//  UICollectionView+Extension.swift
//  OnBoardingScanner
//
//  Created by NB1003917 on 28/2/2567 BE.
//

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cellType: T.Type) {
        register(cellType, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func dequeue<T: UICollectionViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        let identifier = String(describing: cellType)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cellType: \(identifier) at: \(indexPath)")
        }
        
        return cell
    }
    
    func dequeue<T: UICollectionViewCell>(forType type: T.Type, at indexPath: IndexPath) -> T? {
        let identifier = String(describing: type)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T
    }
}
