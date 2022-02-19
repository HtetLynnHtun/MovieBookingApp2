//
//  MovieTimeViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 16/02/2022.
//

import UIKit

class MovieTimeViewController: UIViewController {

    @IBOutlet weak var collectionViewDays: UICollectionView!
    @IBOutlet weak var collectionViewAvailableIn: UICollectionView!
    @IBOutlet weak var collectionViewGCGoldenCity: UICollectionView!
    @IBOutlet weak var collectionViewGCWestPoint: UICollectionView!
    @IBOutlet weak var viewContainerTimes: UIView!
    
    @IBOutlet weak var collectionViewHeightAvailableIn: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightGCGoldenCity: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightGCWestPoint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regsierCells()
        setupDataSourcesAndDelegates()
        setupHeightsForCollectionViews()
        
        viewContainerTimes.clipsToBounds = true
        viewContainerTimes.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        viewContainerTimes.layer.cornerRadius = 16
    }
    
    func regsierCells() {
        collectionViewDays.registerCell(DayCollectionViewCell.identifier)
        collectionViewAvailableIn.registerCell(TimeCollectionViewCell.identifier)
        collectionViewGCGoldenCity.registerCell(TimeCollectionViewCell.identifier)
        collectionViewGCWestPoint.registerCell(TimeCollectionViewCell.identifier)
    }
    
    func setupDataSourcesAndDelegates() {
        collectionViewDays.dataSource = self
        collectionViewDays.delegate = self
        
        collectionViewAvailableIn.dataSource = self
        collectionViewAvailableIn.delegate = self
        
        collectionViewGCWestPoint.dataSource = self
        collectionViewGCWestPoint.delegate = self
        
        collectionViewGCGoldenCity.dataSource = self
        collectionViewGCGoldenCity.delegate = self
    }
    
    func setupHeightsForCollectionViews() {
        collectionViewHeightAvailableIn.constant = 56
        collectionViewHeightGCGoldenCity.constant = 56 * 2
        collectionViewHeightGCWestPoint.constant = 56 * 2
        
        self.view.layoutIfNeeded()
    }

}

extension MovieTimeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewDays) {
            return 10
        } else if (collectionView == collectionViewAvailableIn) {
            return 3
        } else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionViewDays) {
            return collectionViewDays.dequeCell(DayCollectionViewCell.identifier, indexPath)
        } else {
            let cell = collectionViewAvailableIn.dequeCell(TimeCollectionViewCell.identifier, indexPath)
//            cell.layer.borderWidth = 1
//            cell.layer.cornerRadius = 4
            
            return cell
        }
    }
    
}

extension MovieTimeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == collectionViewDays) {
            return CGSize(width: 60, height: 80)
        } else {
            let width = collectionView.bounds.width / 3
            let height = CGFloat(48)
            return CGSize(width: width, height: height)
        }
    }
}
