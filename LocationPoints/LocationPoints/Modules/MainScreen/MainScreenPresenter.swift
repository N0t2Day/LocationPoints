//
//  MainScreenPresenter.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 18.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import Foundation

protocol MainScreenPresenter: class {
    func viewDidLoad()
}

class MainScreenPresenterImplementation: BasePresenter<MainScreenView, MainScreenRouter> {
    
}

extension MainScreenPresenterImplementation: MainScreenPresenter {
    func viewDidLoad() {
        
    }
}
