//
//  MapScene.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import Swinject
import ModelLayer

/// Map scene / DI container builder
class MapScene: Scene {
    override func buildContainer(parent: Container?) -> Container {
        return Container(parent: parent) { container in
            container.register(MapInteractor.self) { r in
                MapInteractor(executors: r.resolve(Executors.self)!,
                              stationService: r.resolve(StationService.self)!,
                              bookingService: r.resolve(BookingService.self)!)
            }
            container.register(MapPresenter.self) { r -> MapPresenter<MapViewController> in
                MapPresenter(interactor: r.resolve(MapInteractor.self)!,
                             navigator: r.resolve(MapNavigator.self)!)
            }
            container.register(MapNavigator.self) { _ in
                MapSceneNavigator(scene: self)
            }
            container.register(UIViewController.self) { r in
                let vc = MapViewController()
                vc.presenter = r.resolve(MapPresenter.self)
                return vc
            }
        }
    }
}
