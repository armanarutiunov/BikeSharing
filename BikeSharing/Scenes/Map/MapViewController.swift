//
//  MapViewController.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit
import ModelLayer
import RxCocoa

class MapViewController: ViewController {

    var presenter: MapPresenter<MapViewController>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.attachView(viewIO: self).disposed(by: disposeBag)
    }

}

extension MapViewController: MapViewIO {
    func show(loading: Bool) {}
}

extension MapViewController {
    
    private func setupView() {
        
    }
    
}
