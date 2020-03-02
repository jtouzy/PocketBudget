//
//  UIView+extensions.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

public extension UIView {
    typealias CenterConstraints = (x: NSLayoutConstraint, y: NSLayoutConstraint)

    static func load<T: UIView>() -> T? {
        return UINib(nibName: T.identifier, bundle: .main)
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
    func addToCenter(of view: UIView, sized size: CGSize? = nil) -> CenterConstraints {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerYConstraint = centerYAnchor.constraint(equalTo: view.centerYAnchor)
        var constraints = [centerXConstraint, centerYConstraint]
        if let size = size {
            constraints.append(contentsOf: [
                widthAnchor.constraint(equalToConstant: size.width),
                heightAnchor.constraint(equalToConstant: size.height)
            ])
        }
        NSLayoutConstraint.activate(constraints)
        return (x: centerXConstraint, y: centerYConstraint)
    }
}

public extension UIView {
    func fromCenterToTop(in view: UIView, topDistance: CGFloat,
                         fadeDuration: TimeInterval = 0.5, moveDuration: TimeInterval = 0.5,
                         completion: (() -> Void)? = nil) {
        alpha = 0
        translatesAutoresizingMaskIntoConstraints = false
        let centerConstraints = addToCenter(of: view)
        let topConstraint = topAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topDistance
        )
        view.layoutIfNeeded()
        UIView.animate(
            withDuration: fadeDuration,
            delay: 0,
            options: .curveEaseInOut,
            animations: { [weak self] in
                self?.alpha = 1
            },
            completion: { _ in
                centerConstraints.y.isActive = false
                topConstraint.isActive = true
                UIView.animate(
                    withDuration: moveDuration,
                    delay: 0,
                    options: .curveEaseInOut,
                    animations: {
                        view.layoutIfNeeded()
                    },
                    completion: { _ in completion?() }
                )
            }
        )
    }
}

extension UIView: UIIdentifiable {}
