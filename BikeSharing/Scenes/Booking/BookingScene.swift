//
//  BookingScene.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 22/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import Swinject
import ModelLayer

class BookingScene: Scene {
    override func buildContainer(parent: Container?) -> Container {
        return Container(parent: parent) { container in
            container.register(BookingInteractor.self) { r in
                BookingInteractor(executors: r.resolve(Executors.self)!,
                                  bookingService: r.resolve(BookingService.self)!)
            }
            container.register(BookingPresenter.self) { r -> BookingPresenter<BookingViewController> in
                BookingPresenter(interactor: r.resolve(BookingInteractor.self)!,
                                 navigator: r.resolve(BookingNavigator.self)!)
            }
            container.register(BookingNavigator.self) { _ in
                BookingSceneNavigator(scene: self)
            }
            container.register(UIViewController.self) { r in
                let vc = BookingViewController()
                vc.presenter = r.resolve(BookingPresenter.self)
                return vc
            }
        }
    }
}
