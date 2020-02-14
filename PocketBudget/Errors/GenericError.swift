//
//  GenericError.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift

enum GenericError: Error {
    case selfIsNil

    func asObservable<T>() -> Observable<T> {
        return Observable.error(self)
    }
}
