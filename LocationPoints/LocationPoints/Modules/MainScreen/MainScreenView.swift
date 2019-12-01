//
//  MainScreenView.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 19.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import UIKit

class MainScreenView: UITabBarController {
    var presenter: MainScreenPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        MainScreenConfigurator().configure(self)
        presenter?.viewDidLoad()
    }

}

extension MainScreenView: BaseView {
    
}
