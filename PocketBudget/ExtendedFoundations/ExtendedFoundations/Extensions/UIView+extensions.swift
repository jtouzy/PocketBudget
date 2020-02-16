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
        return UINib(nibName: T.identifier, bundle: .main)
            .instantiate(withOwner: self, options: nil).first as? T
    }

    func addTo(view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension UIView: UIIdentifiable {}
