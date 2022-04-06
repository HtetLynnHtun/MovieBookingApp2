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
        present(vc, animated: true)
    }
    
    func navigateToHomeScreen() {
        let vc = UIStoryboard.mainStoryBoard().instantiateViewController(withIdentifier: HomeViewController.identifier)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func navigateToScreen(withIdentifier identifier: String) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: identifier)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
    
    func navigateToMovieDetails(id: Int) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: MovieDetailViewController.identifier) as! MovieDetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.contentId = id
        present(vc, animated: true)
    }
    
    func navigateToMovieTime() {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: MovieTimeViewController.identifier) as! MovieTimeViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
