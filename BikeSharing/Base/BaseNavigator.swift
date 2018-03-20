//
//  BaseNavigator.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import Swinject

/// Base Navigator for application. Holds reference to associated DI container.

class BaseNavigator {
    
    let scene: Scene
    
    init(scene: Scene) {
        self.scene = scene
    }
}

