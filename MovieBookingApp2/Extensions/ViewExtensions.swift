//
//  ViewExtensions.swift
//  MovieBookingApp2
//
//  Created by kira on 16/02/2022.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    static var identifier: String {
        String(describing: self)
    }
    
}

extension UICollectionView {
    
    func registerCell(_ cellIdentifier: String) {
        register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func dequeCell<T: UICollectionViewCell>(_ cellIdentifier: String,_ indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? T else {
            return UICollectionViewCell() as! T
        }
        return cell
    }
}

extension UIViewController {
    static var identifier: String {
        String(describing: self)
    }
}
