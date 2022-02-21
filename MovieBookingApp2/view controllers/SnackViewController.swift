//
//  SnackViewController.swift
//  MovieBookingApp2
//
//  Created by kira on 19/02/2022.
//

import UIKit

class SnackViewController: UIViewController {

    @IBOutlet weak var collectionViewSnacks: UICollectionView!
    @IBOutlet weak var collectionViewPaymentMethods: UICollectionView!
    @IBOutlet weak var buttonGoBack: UIButton!
    @IBOutlet weak var buttonPay: UIButton!
    
    @IBOutlet weak var snackCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var paymentMethodCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        setupDataSourcesAndDelegates()
        setupCollectionViewHeights()
        setupGestureRecognizers()
    }
    
    private func setupCollectionViewHeights() {
        // snack count will be dynamic
        let snackCount = 3
        let snackCellHeight = 70
        let snackSpacing = 16
        snackCollectionViewHeight.constant = CGFloat((snackCellHeight * snackCount) + ((snackSpacing * snackCount) - snackSpacing))
        
        let paymentMethodCount = 3
        let paymentMethodCellHeight = 40
        let paymentMethodSpacing = 16
        paymentMethodCollectionViewHeight.constant = CGFloat((paymentMethodCellHeight * paymentMethodCount) + ((paymentMethodSpacing * paymentMethodCount) - paymentMethodSpacing))
    }

    private func registerCells() {
        collectionViewSnacks.registerCell(SnackCollectionViewCell.identifier)
        collectionViewPaymentMethods.registerCell(PaymentMethodCollectionViewCell.identifier)
    }
    
    private func setupDataSourcesAndDelegates() {
        collectionViewSnacks.dataSource = self
        collectionViewSnacks.delegate = self
        
        collectionViewPaymentMethods.dataSource = self
        collectionViewPaymentMethods.delegate = self
    }
    
    private func setupGestureRecognizers() {
        let buttonGoBackTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGoBack))
        buttonGoBack.addGestureRecognizer(buttonGoBackTapGestureRecognizer)
        
        let buttonPayTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPay))
        buttonPay.addGestureRecognizer(buttonPayTapGestureRecognizer)
    }
    
    @objc func didTapGoBack() {
        navigateToScreen(withIdentifier: MovieSeatViewController.identifier)
    }
    
    @objc func didTapPay() {
        navigateToScreen(withIdentifier: PaymentViewController.identifier)
    }
}

extension SnackViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionViewSnacks) {
            let cell = collectionView.dequeCell(SnackCollectionViewCell.identifier, indexPath)
            return cell
        } else {
            let cell = collectionView.dequeCell(PaymentMethodCollectionViewCell.identifier, indexPath)
            return cell
        }
    }
    
    
}

extension SnackViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == collectionViewSnacks) {
            let width = collectionView.bounds.width
            let height = 70.0
            
            return CGSize(width: width, height: height)
        } else {
            let width = collectionView.bounds.width
            let height = 40.0
            
            return CGSize(width: width, height: height)
        }
    }
}
