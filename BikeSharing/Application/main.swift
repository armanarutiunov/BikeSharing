//
//  main.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit

let appDelegateClass: AnyClass? = NSClassFromString("XCTestCase") != nil ? TestingAppDelegate.self : AppDelegate.self
let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))

UIApplicationMain(CommandLine.argc, args, nil, NSStringFromClass(appDelegateClass!))

