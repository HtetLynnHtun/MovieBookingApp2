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
    @IBOutlet weak var buttonPay: UIButton!
    @IBOutlet weak var subTotalLabel: UILabel!
    
    @IBOutlet weak var snackCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var paymentMethodCollectionViewHeight: NSLayoutConstraint!
    
    private var snackModel: SnackModel = SnackModelImpl.shared
    private var paymentMethodModel: PaymentMethodModel = PaymentMethodModelImpl.shared
    private var snacks = [SnackVO]()
    private var paymentMethods = [PaymentMethodVO]()
    
    var courier: CourierVO!
    var ticketCost = 0.0
    var snackCost = 0.0 {
        didSet {
            subTotalLabel.text = "Sub total: \(snackCost)$"
            buttonPay.setTitle("Pay $\(ticketCost + snackCost)", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        registerCells()
        setupDataSourcesAndDelegates()
        getSnacks()
        getPaymentMethods()
        setupGestureRecognizers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func initView() {
        ticketCost = courier.ticketCost
        buttonPay.setTitle("Pay $\(ticketCost)", for: .normal)
    }
    
    private func setupCollectionViewHeights() {
        // snack count will be dynamic
        let snackCount = snacks.count
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
        let buttonPayTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPay))
        buttonPay.addGestureRecognizer(buttonPayTapGestureRecognizer)
    }
    
    @objc func didTapPay() {
        courier.totalPrice = ticketCost + snackCost
        navigateToPayment(courier)
    }
    
    private func updateSubTotal() {
        snackCost = snacks.reduce(0) { $0 + (Double($1.count) * $1.price)}
    }
    
    private func updateButtonPayLabel(_ subTotal: Double) {
        buttonPay.setTitle("Pay $\(40 + subTotal)", for: .normal)
    }
    
    //
    // MARK: - Model Communications
    //
    private func getSnacks() {
        snackModel.getSnacks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let snacks):
                self.snacks = snacks
                self.collectionViewSnacks.reloadData()
                self.setupCollectionViewHeights()
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
    }
    
    private func getPaymentMethods() {
        paymentMethodModel.getPaymentMethods { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.paymentMethods = data
                self.collectionViewPaymentMethods.reloadData()
                self.setupCollectionViewHeights()
            case .failure(let errorMessage):
                self.showAlert(message: errorMessage)
            }
        }
    }
}

extension SnackViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionViewSnacks) {
            return snacks.count
        } else {
            return paymentMethods.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collectionViewSnacks) {
            let cell = collectionView.dequeCell(SnackCollectionViewCell.identifier, indexPath) as SnackCollectionViewCell
            cell.data = snacks[indexPath.row]
            cell.updateSubTotal = updateSubTotal
            return cell
        } else {
            let cell = collectionView.dequeCell(PaymentMethodCollectionViewCell.identifier, indexPath) as PaymentMethodCollectionViewCell
            cell.data = paymentMethods[indexPath.row]
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
