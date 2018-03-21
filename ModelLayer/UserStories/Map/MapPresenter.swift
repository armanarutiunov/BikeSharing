//
//  MapPresenter.swift
//  ModelLayer
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

public class MapPresenter<V: MapViewIO>: Presenter<V> {
    
    private let interactor: MapInteractor
    private let navigator: MapNavigator
    
    public init(interactor: MapInteractor, navigator: MapNavigator) {
        self.interactor = interactor
        self.navigator = navigator
    }
    
}
