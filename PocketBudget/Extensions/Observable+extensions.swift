//
//  Observable+extensions.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 18/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxSwift

extension Observable where Element: Collection {
    func first(orError error: Error) -> Observable<Element.Element> {
        return flatMap { (array: Element) -> Observable<Element.Element> in
            return Observable.from(array.first, orError: error)
        }
    }
}

extension Observable {
    static func from<T>(_ element: T?, orError error: Error) -> Observable<T> {
        if let element = element {
            return .just(element)
        } else {
            return .error(error)
        }
    }
}
