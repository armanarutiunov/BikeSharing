//
//  StationScene.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import Swinject
import ModelLayer

class StationScene: Scene {
    
    private let station: Station
    
    init(station: Station) {
        self.station = station
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    override func buildContainer(parent: Container?) -> Container {
        return Container(parent: parent) { container in
            container.register(StationInteractor.self) { r in
                StationInteractor(executors: r.resolve(Executors.self)!,
                                  bookingService: r.resolve(BookingService.self)!)
            }
            container.register(StationPresenter.self) { r -> StationPresenter<StationViewController> in
                StationPresenter(interactor: r.resolve(StationInteractor.self)!,
                                 navigator: r.resolve(StationNavigator.self)!,
                                 station: self.station)
            }
            container.register(StationNavigator.self) { _ in
                StationSceneNavigator(scene: self)
            }
            container.register(UIViewController.self) { r in
                let vc = StationViewController()
                vc.presenter = r.resolve(StationPresenter.self)
                return vc
            }
        }
    }
}
