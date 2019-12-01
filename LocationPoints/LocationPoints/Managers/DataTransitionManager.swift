//
//  DataTransitionManager.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 22.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import Foundation

class DataTransitionManager {
    static let shared = DataTransitionManager()
    private init() { }
    private var selectedPoint: LPPoint?
    func getSelectedMarker() -> LPPoint? {
        defer { selectedPoint = nil }
        return selectedPoint
    }
    
    func setSelected(marker: LPPoint) {
        self.selectedPoint = marker
    }
}
