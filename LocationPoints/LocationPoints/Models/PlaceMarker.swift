//
//  PlaceMarker.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 20.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import GoogleMaps

class PlaceMarker: GMSMarker {
    let place: LPPoint

    var isSelected = false
    init(place: LPPoint, isSelected: Bool = false) {
        self.place = place
        super.init()
        
        position = place.coordinate
        icon = UIImage(named: "pin")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
        title = place.name
        tracksInfoWindowChanges = true

    }

}
extension PlaceMarker: GMUClusterItem {
    
}
