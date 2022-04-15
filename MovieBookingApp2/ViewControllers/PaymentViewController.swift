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
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var buttonAddNewCard: UIButton!
    @IBOutlet weak var paymentAmountLabel: UILabel!
    
    private var authModel: AuthModel = AuthModelImpl.shared
    private var paymentMethodModel: PaymentMethodModel = PaymentMethodModelImpl.shared
    var courier: CourierVO!
    private var cards = [CardVO]()
    private var selectedCardIndex = 0 {
        didSet {
            courier.cardId = cards[selectedCardIndex].id
            print("wtbug: selectedCardIndex: \(selectedCardIndex)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        print("wtbug: \(courier!)")
        collectionViewCards.dataSource = self
        collectionViewCards.delegate = self
        collectionViewCards.registerCell(CardCollectionViewCell.identifier)
        
        setupCarouselView()
        setupGestureRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .black
        getCards()
        print("wtbug: selectedCardIndex \(selectedCardIndex)")
    }
    
    private func initView() {
        paymentAmountLabel.text = "$ \(courier.totalPrice)"
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
        let buttonConfirmTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapConfirm))
        buttonConfirm.addGestureRecognizer(buttonConfirmTapGestureRecognizer)
        
        let buttonAddNewCardTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapAddNewCard))
        buttonAddNewCard.addGestureRecognizer(buttonAddNewCardTapGestureRecognizer)
    }
    
    @objc func didTapConfirm() {
        paymentMethodModel.checkout(courier: courier) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let checkoutVO):
                self.courier.bookingNo = checkoutVO.bookingNo
                self.courier.qrCode = checkoutVO.qrCode
                self.navigateToTicket(self.courier)
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
        print("wtbug: \(courier!)")
//        navigateToScreen(withIdentifier: TicketViewController.identifier)
    }
    
    @objc func didTapAddNewCard() {
        navigateToAddNewCard()
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

extension PaymentViewController: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = collectionViewCards.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = layout.itemSize.width
        let offset = scrollView.contentOffset.x
        selectedCardIndex = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
}
