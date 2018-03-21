//
//  Application.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import UIKit
import Swinject

/// Main application class. Manages app entry point and holds its root container.
class Application {
    private static let shared = Application()
    
    private let rootScene: RootScene = {
        // Setup root scene with root container
        let root = RootScene()
        
        // Inject DataLayer dependencies in root container
        let assembler = Assembler(container: root.container())
        assembler.apply(assembly: DataLayerAssembly())
        
        return root
    }()
    
    /// App's entry point
    class func configure(_ window: UIWindow) -> UIWindow {
        shared.rootScene.plugInWindow(window)
        
        // Add first scene
        shared.rootScene.push(MapScene())
        
        return window
    }
}
