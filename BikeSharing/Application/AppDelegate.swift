//
//  AppDelegate.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 20/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit
import GoogleMaps

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyASdxaVbY4WRIDh6kPAD9-lYzydIb13Xjw")
        window = Application.configure(UIWindow(frame: UIScreen.main.bounds))
        return true
    }
}

