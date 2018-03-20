//
//  Scene.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import Swinject

/// Scene class. Provides one view controller with all dependencies. Supports parent-child hierarchy.
class Scene {
    private weak var parent: Scene?
    private var _container: Container?
    
    required init() {}
    
    /// Lazy accessor to internal DI container which is built after `self` and `parent` will be initialized
    final func container() -> Container {
        if _container == nil {
            _container = buildContainer(parent: parent?.container())
        }
        return _container!
    }
    
    /// Container builder. Should be overriden in subclasses
    open func buildContainer(parent: Container?) -> Container {
        fatalError("not implemented")
    }
    
    /// Set new scene as first scene in navigation stack
    func setFirst(_ scene: Scene, animated: Bool = true) {
        scene.parent = root
        
        let nc = root?.container().resolve(UINavigationController.self)
        let vc = scene.viewController
        if let lastVc = nc?.viewControllers.last {
            if type(of: vc) == type(of: lastVc) {
                return
            }
        }
        
        nc?.setViewControllers([vc], animated: animated)
        scene.dismiss(animated: false)
    }
    
    /// Present child scene modally
    func present(_ scene: Scene, animated: Bool = true, completion: (()->())? = nil) {
        scene.parent = self
        container().resolve(UINavigationController.self)?.present(scene.viewController, animated: animated, completion: completion)
    }
    
    /// Dismiss scene
    func dismiss(animated: Bool = true, competion: (() -> Void)? = nil) {
        container().resolve(UINavigationController.self)?.dismiss(animated: animated, completion: competion)
    }
    
    /// Push child scene in navigation stack
    func push(_ scene: Scene, animated: Bool = true, popLastN: Int = 0) {
        scene.parent = self
        if var stack = container().resolve(UINavigationController.self)?.viewControllers, popLastN > 0 {
            for _ in 0..<popLastN { _ = stack.popLast() }
            stack.append(scene.viewController)
            container().resolve(UINavigationController.self)?.setViewControllers(stack, animated: animated)
        }
        else {
            container().resolve(UINavigationController.self)?.pushViewController(scene.viewController, animated: animated)
        }
    }
    
    /// Pop child scene from navigation stack
    func pop(animated: Bool = true) {
        container().resolve(UINavigationController.self)?.popViewController(animated: animated)
    }
    
    /// Pop to root vc
    func popToRoot(animated: Bool = true) {
        container().resolve(UINavigationController.self)?.popToRootViewController(animated: animated)
    }
    
    /// Associated scene's view controller
    var viewController: UIViewController {
        return container().resolve(UIViewController.self)!
    }
    
    /// Root scene
    private var root: Scene? {
        var node = parent
        while node?.parent != nil {
            node = node?.parent
        }
        return node ?? self
    }
}
