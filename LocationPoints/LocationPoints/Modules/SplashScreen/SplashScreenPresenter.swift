//
//  SplashScreenPresenter.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 18.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

protocol SplashScreenPresenter: class {
    func viewDidLoad()
    func viewDidAppear()
    func didTapSignIn()
}

class SplashScreenPresenterImplementation: BasePresenter<SplashScreenView, SplashScreenRouter> {
    
}


extension SplashScreenPresenterImplementation: SplashScreenPresenter {
    
    func viewDidLoad() {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = view
    }
    
    func viewDidAppear() {
        if let _ = Auth.auth().currentUser {
            router.toMainScreen()
        }
    }
    
    func didTapSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @objc func showError(error: Error) {
        view.showError(error) {
            
        }
    }
    
}

extension SplashScreenPresenterImplementation: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            performSelector(onMainThread: #selector(showError(error:)), with: err, waitUntilDone: false)
            return
        }
        
        guard let auth = user.authentication,
            let token = auth.idToken,
            let accessToken = auth.accessToken else { return }
        GIDSignIn.sharedInstance()?.signOut()
        let credential = GoogleAuthProvider.credential(withIDToken: token, accessToken: accessToken)
        Auth.auth().signIn(with: credential) {[weak self] authData, error in
            guard let strongSelf = self else { return }
            if let err = error {
                strongSelf.performSelector(onMainThread: #selector(strongSelf.showError(error:)), with: err, waitUntilDone: false)
                return
            }
            guard let _ = authData?.user.uid else { return }
            strongSelf.router.toMainScreen()
        }
        
    }
    
}
