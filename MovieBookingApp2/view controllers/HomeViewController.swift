//
//  ViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 16/02/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionViewNowShowing: UICollectionView!
    @IBOutlet weak var collectionViewComingSoon: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupDataSourceAndDelegates()
    }

    func registerCells() {
        collectionViewNowShowing.registerCell(MovieCollectionViewCell.identifier)
        collectionViewComingSoon.registerCell(MovieCollectionViewCell.identifier)
    }
    
    func setupDataSourceAndDelegates() {
        collectionViewNowShowing.dataSource = self
        collectionViewNowShowing.delegate = self
        
        collectionViewComingSoon.dataSource = self
        collectionViewComingSoon.delegate = self
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionViewNowShowing.dequeCell(MovieCollectionViewCell.identifier, indexPath)
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2.5
        let height = CGFloat(280)
        
        return CGSize(width: width, height: height)
    }
}
