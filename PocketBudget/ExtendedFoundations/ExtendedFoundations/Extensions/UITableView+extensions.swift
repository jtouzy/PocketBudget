//
//  UITableView+extensions.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 04/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

public extension UITableView {
    func registerNib<T: UIView>(_ viewType: T.Type) {
        register(
            UINib(nibName: viewType.identifier, bundle: Bundle(for: viewType)),
            forCellReuseIdentifier: viewType.identifier
        )
    }
}
