//
//  ProfileScreenPresenter.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 19.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import Foundation
import Firebase
protocol ProfileScreenPresenter {
    func viewDidLoad()
    func signOut()
}

class ProfileScreenPresenterImplementation: BasePresenter<ProfileScreenView, ProfileScreenRouter> {
    
}

extension ProfileScreenPresenterImplementation: ProfileScreenPresenter {
    func viewDidLoad() {
        
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        router.backToLogin()
    }
}
