//
//  MapSceneNavigator.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import ModelLayer

class MapSceneNavigator: BaseNavigator, MapNavigator {
    func toStation(_ station: Station) {
        scene.push(StationScene(station: station))
    }
    
    func toBooking() {
        scene.push(BookingScene())
    }
}
