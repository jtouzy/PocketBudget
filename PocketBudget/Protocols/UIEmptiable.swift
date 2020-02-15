//
//  UIEmptiable.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 15/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import UIKit

typealias IfEmpty = (Signal<()>) -> Void

protocol UIEmptiable {
    var emptyView: EmptyView? { get set }
    mutating func evaluateEmptiness<T>(for data: T, ifEmpty: IfEmpty?) where T: Collection
}

extension UIEmptiable where Self: UIViewController {
    mutating func evaluateEmptiness<T>(for data: T, ifEmpty: IfEmpty?) where T: Collection {
        if data.isEmpty {
            guard
                emptyView == nil,
                let newEmptyView: EmptyView = UIView.load()
            else {
                return
            }
            newEmptyView.addTo(view: self.view)
            ifEmpty?(newEmptyView.actionButtonSignal)
            emptyView = newEmptyView
        } else {
            emptyView?.removeFromSuperview()
            emptyView = nil
        }
    }
}
