//
//  ControlEvent+Extras.swift
//  BikeSharing
//
//  Created by Arman Arutyunov on 21/03/2018.
//  Copyright © 2018 Arman Arutyunov. All rights reserved.
//

import RxSwift
import RxCocoa

extension ControlEvent {
    public func asAction(_ sideEffectHandler: @escaping () -> Void = {}) -> Driver<Void> {
        return map { _ in }
            .do(onNext: { _ in sideEffectHandler() })
            .asDriver(onErrorDriveWith: .never())
    }
}

