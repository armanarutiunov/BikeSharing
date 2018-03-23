//
//  MapPresenter.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift

public class MapPresenter<V: MapViewIO>: Presenter<V> {
    
    private let interactor: MapInteractor
    private let navigator: MapNavigator
    
    public init(interactor: MapInteractor, navigator: MapNavigator) {
        self.interactor = interactor
        self.navigator = navigator
    }
    
    override func setup() {
        
    }
    
    override func viewAttached() -> Disposable {
        guard let viewIO = viewIO else { return Disposables.create() }
        
        return disposable(
            interactor.getStations()
                .subscribe(
                    onNext: { stations in
                        viewIO.showStations(stations)
                    },
                    onError: { error in
                        viewIO.showError(ErrorWithRecovery(error.localizedDescription))
                    }
                ),
            viewIO.stationTapped.drive(onNext: { [weak self] station in
                self?.navigator.toStation(station)
            })
        )
    }
}
