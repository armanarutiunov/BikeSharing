//
//  StationPresenter.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift
import RxCocoa

public class StationPresenter<V: StationViewIO>: Presenter<V> {
    
    private let interactor: StationInteractor
    private let navigator: StationNavigator
    private let station: Station
    private let bikes = BehaviorRelay<[Bike]>(value: [Bike]())
    
    public init(interactor: StationInteractor, navigator: StationNavigator, station: Station) {
        self.interactor = interactor
        self.navigator = navigator
        self.station = station
    }
    
    override func setup() {
        bikes.accept(station.bikes)
        viewIO?.showBikes(bikes.value)
    }
    
    override func viewAttached() -> Disposable {
        guard let viewIO = viewIO else { return Disposables.create() }
        
        return disposable(
            viewIO.backButtonPressed.drive(onNext: { [weak self] in
                self?.navigator.back()
            }),
            viewIO.bookBike.drive(onNext: { [weak self] index in
                 self?.navigator.toBooking()
            })
        )
    }
    
}
