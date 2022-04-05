//
//  GoogleAuth.swift
//  MovieBookingApp2
//
//  Created by kira on 05/04/2022.
//

import Foundation
import GoogleSignIn
import UIKit

public class GoogleAuth : NSObject {
    
    static let shared = GoogleAuth()
    
    private override init() {
        super.init()
    }
    
    private let OAUTH_ID_GOOGLE_SIGN_IN = "1022496941903-pob60acdom7o7non4k0s2tarimg6v6q6.apps.googleusercontent.com" // TODO: Add your key here
    
    public func start(
        view : UIViewController?,
        success: @escaping ((GoogleAuthProfileResponse) -> Void),
        failure: @escaping ((String) -> Void) ) {
        
        print("Google-Sign-In Authentication Started")
        
        guard let viewController = view else {
            failure("Referencing view controller is nil")
            return
        }
        
        let signInConfig = GIDConfiguration(clientID: OAUTH_ID_GOOGLE_SIGN_IN)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: viewController) { [weak self] (user, error) in
            guard let self = self else { return } /// If nil, viewcontroller reference is already gone.
            
            if let error = self.handleSignInError(error) {
                print("Google-Sign-In ended with error.")
                failure(error)
            }
            
            
            if let userData = self.handleUserData(user) {
                print("Google-Sign-In completed successfully.")
                success(userData)
            } else {
                failure("\(#function) Google-Sign-In returns no user information")
            }
        }
    
    }
    
    private func handleSignInError(_ error : Error?) -> String? {
        /// Handle Error
        if let error = error {
            let errorCode : Int = (error as NSError).code
            switch errorCode {
            case GIDSignInError.hasNoAuthInKeychain.rawValue:
                return "The user has not signed in before or they have since signed out."
            default:
                return "\(error.localizedDescription)"
            }
        }
        return nil
    }
    
    
    private func handleUserData(_ user : GIDGoogleUser?) -> GoogleAuthProfileResponse? {
        /// Handle User Information
        guard let user = user else {
            return nil
        }
        
        // Perform any operations on signed in user here.
        let userId = user.userID ?? "" // For client-side use only!
        let token = user.authentication.idToken ?? ""
        let fullName = user.profile?.name ?? ""
        let givenName = user.profile?.givenName ?? ""
        let familyName = user.profile?.familyName ?? ""
        let email = user.profile?.email ?? ""
        
        let userData = GoogleAuthProfileResponse(
            id: userId,
            token: token,
            fullname: fullName,
            giveName: givenName,
            familyName: familyName,
            email: email
        )
        
        return userData
    }
}

public struct GoogleAuthProfileResponse {
    public let id, token, fullname, giveName, familyName, email : String
}
