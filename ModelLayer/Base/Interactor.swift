//
//  Interactor.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift


/// Base interactor class
/// Interactor ties up various use cases together; all interaction with model layer (Platform-specific Domain) should happen here
open class Interactor {
    let executors: Executors
    
    
    /// Initialize an interactor
    ///
    /// - Parameters:
    ///   - worker: scheduler on which the work gets done
    ///   - notifier: scheduler on which the result is delivered
    public init(executors: Executors){
        self.executors = executors
    }
    
    /// Transforms source Observable in a way that it is executed on specified worker thread and notified
    /// on specified notification thread
    ///
    /// - Parameters:
    ///   - source: source observable to transform, usually some raw Observable coming from Repository/Data access layer
    /// - Returns: Observable to be finally subscribed to; Presenter generally should not override schedulers of this Observable
    public func applySchedulers<T>(_ source: Observable<T>) -> Observable<T>{
        return source
            .subscribeOn(executors.worker)
            .observeOn(executors.notifier)
    }
}


