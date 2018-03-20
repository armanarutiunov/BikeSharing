//
//  Executors.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift


/// Executors to be used throughout the application, in Interactors
public protocol Executors {
    
    /// Scheduler used for doing the heavy job
    var worker: ImmediateSchedulerType { get }
    
    /// Scheduler used for receiving notifications from Observable
    var notifier: ImmediateSchedulerType { get }
    
}


/// Standard executors to be used through app
public class StandardExecutors: Executors {
    
    public init() {}
    
    public var notifier: ImmediateSchedulerType {
        return MainScheduler.instance
    }
    
    public var  worker: ImmediateSchedulerType {
        return SerialDispatchQueueScheduler(internalSerialQueueName: "serialQueue")
    }
    
}


public class TestBlockingExecutors : Executors{
    
    public init() {}
    
    public var notifier: ImmediateSchedulerType {
        return CurrentThreadScheduler.instance
    }
    
    public var worker: ImmediateSchedulerType {
        return CurrentThreadScheduler.instance
    }
    
}
