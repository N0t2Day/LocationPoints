//
//  ProfileScreenRouter.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 19.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import Foundation

class ProfileScreenRouter: BaseRouter<ProfileScreenView> {
    
}

extension ProfileScreenRouter {
    func backToLogin() {
        guard let loginView = instantiateViewController(from: .splash, with: .splash) as? SplashScreenView else { return }
        view.replaceWithRoot(view: loginView, animated: false)
    }
}
