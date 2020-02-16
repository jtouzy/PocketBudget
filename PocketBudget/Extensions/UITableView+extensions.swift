//
//  UITableView+extensions.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import ExtendedFoundations
import RxCocoa
import RxSwift
import UIKit

extension UITableView {
    func bindContent<T, C>(
        with driver: Driver<T>,
        cell: C.Type,
        configurationCompletion: @escaping (T.Element, C) -> Void
    ) -> Disposable where T: Sequence, C: UITableViewCell {
        return driver.drive(
            rx.items(cellIdentifier: C.identifier)
        ) { configurationCompletion($1, $2) }
    }

    func bindSelection<T>(to relay: PublishRelay<T>) -> Disposable {
        return rx.modelSelected(T.self).asSignal().emit(to: relay)
    }

    func bindDeletion<T>(to relay: PublishRelay<T>) -> Disposable {
        return rx.modelDeleted(T.self).asSignal().emit(to: relay)
    }
}
