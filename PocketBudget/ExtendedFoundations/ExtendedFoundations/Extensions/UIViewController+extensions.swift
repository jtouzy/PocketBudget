//
//  UIViewController+extensions.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

public extension UIViewController {
    static func load<T: UIViewController>(from storyboardName: String) -> T? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        return storyboard.instantiateViewController(identifier: T.identifier) as? T
    }
}

extension UIViewController: UIIdentifiable {}
