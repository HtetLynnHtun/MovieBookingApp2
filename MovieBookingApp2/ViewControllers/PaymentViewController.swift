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
    @IBOutlet weak var buttonGoBack: UIButton!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var buttonAddNewCard: UIButton!
    
    private var authModel: AuthModel = AuthModelImpl.shared
    var courier: CourierVO!
    private var cards = [CardVO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("wtbug: \(courier!)")
        collectionViewCards.dataSource = self
        collectionViewCards.registerCell(CardCollectionViewCell.identifier)
        
        getCards()
        setupCarouselView()
        setupGestureRecognizers()
    }

    private func setupCarouselView() {
        let layout = UPCarouselFlowLayout()
        layout.itemSize.width = view.bounds.width * 0.8
        layout.itemSize.height = 200
        layout.scrollDirection = .horizontal
        layout.sideItemScale = 0.8
        layout.sideItemAlpha = 0.5
        layout.spacingMode = .overlap(visibleOffset: view.bounds.width * 0.05)
        collectionViewCards.collectionViewLayout = layout
    }
    
    private func setupGestureRecognizers() {
        let buttonGoBackTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapGoBack))
        buttonGoBack.addGestureRecognizer(buttonGoBackTapGestureRecognizer)
        
        let buttonConfirmTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapConfirm))
        buttonConfirm.addGestureRecognizer(buttonConfirmTapGestureRecognizer)
        
        let buttonAddNewCardTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapAddNewCard))
        buttonAddNewCard.addGestureRecognizer(buttonAddNewCardTapGestureRecognizer)
    }
    
    @objc func didTapGoBack() {
        navigateToScreen(withIdentifier: SnackViewController.identifier)
    }
    
    @objc func didTapConfirm() {
        navigateToScreen(withIdentifier: TicketViewController.identifier)
    }
    
    @objc func didTapAddNewCard() {
        navigateToScreen(withIdentifier: AddNewCardViewController.identifier)
    }
    
    //
    // MARK: - Model Communications
    //
    private func getCards() {
        authModel.getProfile { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let profileVO):
                self.cards = Array(profileVO.cards)
                self.collectionViewCards.reloadData()
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
    }
}

extension PaymentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(CardCollectionViewCell.identifier, indexPath) as CardCollectionViewCell
        cell.data = cards[indexPath.row]
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    
}
