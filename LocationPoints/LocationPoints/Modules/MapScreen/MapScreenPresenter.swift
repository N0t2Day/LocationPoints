//
//  MapScreenPresenter.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 19.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import Foundation
import CoreLocation

typealias Markers = [PlaceMarker]

protocol MapScreenPresenter {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func didIdle()
    func insertNewPoint(name: String, longitude: Double, latitude: Double)
    var isFirstLoaded: Bool {get set}
}

class MapScreenPresenterImplementation: BasePresenter<MapScreenView, MapScreenRouter> {

    let database = AppManager.RTDB
    private var firstLoaded: Bool = false
    var passedPoint: LPPoint? {
        didSet {
            guard let point = passedPoint else { return }
            view.cameraUpdate(for: point)
        }
    }
    var markers: Markers = [] {
        willSet {
            view.clearMap()
        }
        didSet {
            view.setMapForPlace(places: markers)
        }
    }
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()

    @objc func updateCameraPosition(_ position: CLLocation) {
        view.cameraUpdate(for: position.coordinate)
    }
    @objc func didUpdateData() {
        markers = database.items.map{ PlaceMarker(place: $0) }
    }
    
    
}

extension MapScreenPresenterImplementation: MapScreenPresenter {
    
    var isFirstLoaded: Bool {
        get { firstLoaded }
        set { firstLoaded = newValue }
    }
    
    func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateData)
        , name: DataDidUpdateNotification, object: nil)
        locationManager.startUpdatingLocation()
    }
    
    func viewWillAppear() {
        /**
         iOS app freezes when loading custom info window for marker on Google Maps
         https://stackoverflow.com/questions/36746786/ios-app-freezes-when-loading-custom-info-window-for-marker-on-google-maps
         */
        markers = database.items.map{ PlaceMarker(place: $0) }
    }
    
    func viewDidAppear() {
        guard firstLoaded else { return }
        passedPoint = DataTransitionManager.shared.getSelectedMarker()
    }
    
    func didIdle() {
        guard !firstLoaded else { return }
        passedPoint = DataTransitionManager.shared.getSelectedMarker()
    }

    func insertNewPoint(name: String, longitude: Double, latitude: Double) {
        try? database.insertNewPoint(name: name, longitude: longitude, latitude: latitude)
    }
    
}

extension MapScreenPresenterImplementation: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard passedPoint == nil else { return }
        let location = locations.last
        performSelector(onMainThread: #selector(updateCameraPosition(_:)), with: location, waitUntilDone: false)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined: break
        case .restricted: break
        case .denied: break
        case .authorizedAlways, .authorizedWhenInUse:
        manager.startUpdatingLocation()
        @unknown default: break
        }
    }
}
