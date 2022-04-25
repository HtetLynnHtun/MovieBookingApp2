//
//  Router.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import Foundation
import UIKit

extension UIStoryboard {
    static func mainStoryBoard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIViewController {
    
    func navigateToAuthScreen() {
        let vc = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: AuthenticationViewController.identifier)
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToHomeScreen() {
        let vc = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: HomeViewController.identifier)
        self.navigationController?.setViewControllers([vc], animated: true)
    }
    
    func navigateToScreen(withIdentifier identifier: String) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: identifier)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
    
    func navigateToMovieDetails(_ courier: CourierVO) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: MovieDetailViewController.identifier) as! MovieDetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.courier = courier
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieTime(_ courier: CourierVO) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: MovieTimeViewController.identifier) as! MovieTimeViewController
        vc.modalPresentationStyle = .fullScreen
        vc.courier = courier
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToMovieSeat(_ courier: CourierVO) {
        let vc = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: MovieSeatViewController.identifier) as! MovieSeatViewController
        vc.modalPresentationStyle = .fullScreen
        vc.courier = courier
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToSnackPage(_ courier: CourierVO) {
        let vc = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: SnackViewController.identifier) as! SnackViewController
        vc.modalPresentationStyle = .fullScreen
        vc.courier = courier
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToPayment(_ courier: CourierVO) {
        let vc = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: PaymentViewController.identifier) as! PaymentViewController
        vc.modalPresentationStyle = .fullScreen
        vc.courier = courier
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAddNewCard() {
        let vc = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: AddNewCardViewController.identifier) as! AddNewCardViewController
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToTicket(_ courier: CourierVO) {
        let vc = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: TicketViewController.identifier) as! TicketViewController
        vc.modalPresentationStyle = .fullScreen
        vc.courier = courier
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
