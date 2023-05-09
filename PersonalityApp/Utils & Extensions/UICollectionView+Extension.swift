//
//  UICollectionView+Extension.swift
//  PersonalityApp
//
//  Created by Mehmed Tukulic on 10. 5. 2023..
//

import UIKit

extension UICollectionView {
    // Register a UICollectionViewCell with cell type
    func registerCell<T>(ofType: T.Type) where T: UICollectionViewCell {
        register(UINib(nibName: T.identifier, bundle: nil), forCellWithReuseIdentifier: T.identifier)
    }

    // Dequeue a UICollectionViewCell which has the same nib name and identifier as its class name.
    public func dequeueReusableCell<T>(ofType: T.Type, indexPath: IndexPath) -> T where T: UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
