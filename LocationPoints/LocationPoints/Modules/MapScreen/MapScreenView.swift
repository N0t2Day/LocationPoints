//
//  MapScreenView.swift
//  LocationPoints
//
//  Created by Artem Kedrov on 19.11.2019.
//  Copyright © 2019 Artem Kedrov. All rights reserved.
//

import UIKit
import GoogleMaps

class MapScreenView: UIViewController {
    
    let default_zoom: Float = 17.0
    var presenter: MapScreenPresenter?
    
    lazy var infoWindow: InfoWindow = {
        let info: InfoWindow = .fromNib()
        info.isHidden = true
        info.frame.size = CGSize(width: 150, height: 75)
        view.addSubview(info)
        return info
    }()
    
    lazy var renderer: GMUDefaultClusterRenderer = {
        let iconGenerator = GMUDefaultClusterIconGenerator(buckets: [3, 10, 20, 100, 1000], backgroundImages: [UIImage(named: "greem_circle")!, UIImage(named: "greem_circle")!, UIImage(named: "greem_circle")!, UIImage(named: "greem_circle")!, UIImage(named: "greem_circle")!])
        let renderer = GMUDefaultClusterRenderer(mapView: mapView,
                                                 clusterIconGenerator: iconGenerator)
        renderer.delegate = self
        return renderer
    }()
    @IBOutlet private weak var mapView: GMSMapView!
    private lazy var clusterManager: GMUClusterManager = {
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm,
                                               renderer: renderer)
        return clusterManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MapScreenConfigurator().configure(self)
        presenter?.viewDidLoad()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        clusterManager.cluster()
        clusterManager.setDelegate(self, mapDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideInfoWindow()
    }
    
    func showInfoWindow(place: LPPoint) {
        infoWindow.isHidden = false
        infoWindow.frame.origin =  mapView?.projection.point(for: place.coordinate) ?? .zero
        infoWindow.updateWith(with: place)
    }
    
    func hideInfoWindow() {
        infoWindow.isHidden = true
    }
    
}

extension MapScreenView: BaseView {
    
    func clearMap() {
        mapView.clear()
    }
    
    func cameraUpdate(for point: LPPoint, isZoomed: Bool = false) {
        cameraUpdate(for: point.coordinate, isZoomed: isZoomed)
        showInfoWindow(place: point)
    }
    
    func cameraUpdate(for coordinate: CLLocationCoordinate2D, isZoomed: Bool = false) {
        let newCamera = GMSCameraPosition.camera(withTarget: coordinate,
                                                   zoom: mapView.camera.zoom + (isZoomed ? 2 : 0))
          let update = GMSCameraUpdate.setCamera(newCamera)
          mapView.moveCamera(update)
    }
    
    func setMapForPlace(places: Markers) {
        clusterManager.add(places)
        clusterManager.cluster()
    }
    

}

extension MapScreenView: GMSMapViewDelegate {
    func mapViewDidFinishTileRendering(_ mapView: GMSMapView) {
        
    }
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        presenter?.didIdle()
        presenter?.isFirstLoaded = true
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let placeMarker = marker.userData as? PlaceMarker {
            placeMarker.isSelected = !placeMarker.isSelected
            cameraUpdate(for: placeMarker.place)
            placeMarker.isSelected ? showInfoWindow(place: placeMarker.place) : hideInfoWindow()
        }
        return true
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        guard !infoWindow.isHidden else { return }
        hideInfoWindow()
    }
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        showAlert(with: "New point", message: "Please enter new point name") {[weak self] name in
            guard let name = name, let strongSelf = self else { return }
            strongSelf.presenter?.insertNewPoint(name: name, longitude: coordinate.longitude, latitude: coordinate.latitude)
        }
    }
    
}

extension MapScreenView: GMUClusterManagerDelegate {
    func clusterManager(_ clusterManager: GMUClusterManager, didTap cluster: GMUCluster) -> Bool {
        cameraUpdate(for: cluster.position)
        return true
    }  
}

extension MapScreenView: GMUClusterRendererDelegate {
    func renderer(_ renderer: GMUClusterRenderer, willRenderMarker marker: GMSMarker) {
        if marker.userData is PlaceMarker {
            marker.icon = UIImage(named: "pin")
        }
    }
}
