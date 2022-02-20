//
//  PaymentViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import UIKit
import UPCarouselFlowLayout

class PaymentViewController: UIViewController {

    @IBOutlet weak var collectionViewCards: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewCards.dataSource = self
        collectionViewCards.registerCell(CardCollectionViewCell.identifier)
        
        let layout = UPCarouselFlowLayout()
        layout.itemSize.width = 338
        layout.itemSize.height = 200
        layout.scrollDirection = .horizontal
        layout.sideItemScale = 0.8
        layout.sideItemAlpha = 0.5
        layout.spacingMode = .overlap(visibleOffset: 20)
        collectionViewCards.collectionViewLayout = layout
    }

}

extension PaymentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(CardCollectionViewCell.identifier, indexPath)
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    
}
