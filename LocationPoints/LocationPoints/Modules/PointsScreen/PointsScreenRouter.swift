//
//  PointsScreenRouter.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 18.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import Foundation

class PointsScreenRouter: BaseRouter<PointsScreenView> {
    
}

extension PointsScreenRouter {
    func toMap() {
        guard let parent = view.parent as? MainScreenView, let index = parent.viewControllers?.firstIndex(where: { $0.self is MapScreenView }) else { return }
        parent.selectedIndex = index
    }
}
