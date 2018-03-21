//
//  StationSceneNavigator.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import ModelLayer

class StationSceneNavigator: BaseNavigator, StationNavigator {
    func back() {
        scene.pop()
    }
    
    func toBooking() {
        
    }
}
