//
//  ProfileScreenView.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 19.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import UIKit

class ProfileScreenView: UIViewController {
    var presenter: ProfileScreenPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileScreenConfigurator().configure(self)
        presenter?.viewDidLoad()
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        showError(title: "Why?", message: "Are you sure you want to log out", okAction: {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.presenter?.signOut()
        }, deniedAction: nil)
    }
    
}

extension ProfileScreenView: BaseView {
  
}
