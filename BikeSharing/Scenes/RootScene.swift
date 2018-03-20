//
//  RootScene.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import Swinject

class RootScene: Scene {
    override func buildContainer(parent: Container?) -> Container {
        return Container() { container in
            container.register(UINavigationController.self) { _ in
                let rootController = UINavigationController()
                rootController.isNavigationBarHidden = true
                return rootController
                }.inObjectScope(.container)
        }
    }
    
    func plugInWindow(_ window: UIWindow) {
        window.rootViewController = container().resolve(UINavigationController.self)
        window.makeKeyAndVisible()
    }
}
