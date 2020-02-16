//
//  UIView+extensions.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

public extension UIView {
    static func load<T: UIView>() -> T? {
        return UINib(nibName: String(describing: self), bundle: .main)
            .instantiate(withOwner: self, options: nil).first as? T
    }

    func loadFromNib() {
        Self.load()?.addTo(view: self)
    }

    func addTo(view: UIView, constant: CGFloat? = nil) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @discardableResult
    func addToCenter(of view: UIView, sized size: CGSize) -> [NSLayoutConstraint] {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height)
        ]
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}

extension UIView: UIIdentifiable {}
