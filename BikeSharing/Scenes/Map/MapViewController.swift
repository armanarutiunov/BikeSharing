//
//  MapViewController.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit
import ModelLayer
import RxSwift
import RxCocoa
import GoogleMaps

class MapViewController: ViewController {
    
    @IBOutlet weak var statusView: StatusView!
    @IBOutlet weak var mapView: GMSMapView!
    
    var presenter: MapPresenter<MapViewController>!
    let locationManager = CLLocationManager()
    
    private let stationTappedSignal = PublishSubject<Station>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.attachView(viewIO: self).disposed(by: disposeBag)
    }
    
}

extension MapViewController: MapViewIO {
    
    var timerFinished: Action {
        return statusView.timerFinishSignal.asDriver(onErrorDriveWith: .never())
    }
    
    var stationTapped: Driver<Station> {
        return stationTappedSignal.asDriver(onErrorDriveWith: .never())
    }
    
    func showStations(_ stations: [Station]) {
        createMarkers(for: stations)
    }
    
    func updateStatus(state: State, time: TimeInterval?) {
        statusView.state = state
        if let time = time {
            statusView.time = time
        }
    }
    
    func endedRide() {
        statusView.state = .closed
        statusView.stopwatch.invalidate()
    }
    
    func show(loading: Bool) {}
}

extension MapViewController {
    
    private func setupView() {
        setupMap()
    }
    
    private func setupMap() {
        let position = CLLocationCoordinate2D(latitude: 50.142695, longitude: 8.660534)
        mapView.camera = GMSCameraPosition.camera(withTarget: position, zoom: 12)
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    private func createMarkers(for stations: [Station]) {
        stations.forEach { station in
            let position = CLLocationCoordinate2D(latitude: station.location.latitude, longitude: station.location.longtitude)
            let marker = GMSMarker(position: position)
            marker.icon = GMSMarker.markerImage(with: UIColor.cobiBlue)
            marker.map = mapView
            marker.userData = station
        }
    }
    
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let station = marker.userData as? Station {
            stationTappedSignal.onNext(station)
        }
        return true
    }
    
}
