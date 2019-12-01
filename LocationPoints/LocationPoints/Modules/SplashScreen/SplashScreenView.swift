//
//  SplashScreenView.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 18.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class SplashScreenView: UIViewController {
    
    var presenter: SplashScreenPresenter?
    
    @IBOutlet private weak var btnSignIn: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SplashScreenConfigurator().configure(self)
        presenter?.viewDidLoad()
        btnSignIn.layer.cornerRadius = btnSignIn.bounds.width * 0.1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    @IBAction func signIn(_ sender: UIButton) {
        presenter?.didTapSignIn()
    }
    
}

extension SplashScreenView: BaseView {

}
