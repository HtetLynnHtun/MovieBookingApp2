//
//  Router.swift
//  MovieBookingApp2
//
//  Created by kira on 20/02/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func navigateToScreen(withIdentifier identifier: String) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryBoard.instantiateViewController(withIdentifier: identifier)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
}
