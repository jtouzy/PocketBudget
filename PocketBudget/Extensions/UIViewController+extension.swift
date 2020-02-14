//
//  UIViewController+extension.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

extension UIViewController: UIIdentifiable {
    static let mainStoryboard = "Application"

    static func load<T: UIViewController>() -> T? {
        let storyboard = UIStoryboard(name: mainStoryboard, bundle: .main)
        return storyboard.instantiateViewController(identifier: T.identifier) as? T
    }
}
