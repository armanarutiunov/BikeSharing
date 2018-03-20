//
//  Presenter.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift
import RxCocoa

/// Base presenter class
/// To start presenting anything, attach view to Presenter
/// To stop, detach view
public class Presenter<V: ViewIO> {
    
    private(set) weak var viewIO: V?
    private var isSetup = false
    fileprivate let activityIndicator = ActivityIndicator()
    internal var disposeBag = DisposeBag()
    
    /// Attaches view to presenter; presenter will subscribe to outputs of View and performs all its internal operations after attachView is called
    ///
    /// - Parameter view: view to attach
    final public func attachView(viewIO: V) -> Disposable {
        self.viewIO = viewIO
        self.disposeBag = DisposeBag() // clean up previous subscriptions
        
        // lazy setup
        if !isSetup {
            isSetup = true
            setup()
        }
        
        return CompositeDisposable(
            // allow tracking of Observable activity status
            activityIndicator.asDriver()
                .drive(onNext: { [weak self] in self?.viewIO?.show(loading: $0) } ),
            viewAttached()
        )
    }
    
    /// Main entry point to Presenter, manage subscriptions here
    internal func viewAttached() -> Disposable {
        fatalError("This function should be overriden")
    }
    
    /// Setups presenter's initial state, start async operation, etc
    /// Called only once upon `attachView`
    internal func setup() {
        //no op
    }
    
    /// Disposable builder
    internal func disposable(_ disposables: Disposable?...) -> Disposable {
        return Disposables.create(disposables.flatMap{ $0 })
    }
    
}

extension ObservableConvertibleType {
    /// Track activity of Observable with presenter
    ///
    /// - Parameter presenter: presenter to track the observable completion
    /// - Returns: transformed Observable that will notify presenter about completion status
    public func trackActivity<V>(_ presenter: Presenter<V>) -> Observable<E> {
        return presenter.activityIndicator.trackActivityOfObservable(self)
    }
}

// Shortcut
public typealias Action = Driver<Void>

