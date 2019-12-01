//
//  SplashScreenRouter.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 18.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import Foundation

class SplashScreenRouter: BaseRouter<SplashScreenView> {
    func toMainScreen() {
        guard let mainScreenView = instantiateViewController(from: .main, with: .main) as? MainScreenView else { return }
        view.replaceWithRoot(view: mainScreenView)
    }
}
