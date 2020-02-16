//
//  UIIdentifiable.swift
//  ExtendedFoundations
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

public protocol UIIdentifiable {
    static var identifier: String { get }
}

public extension UIIdentifiable {
    static var identifier: String {
        String(describing: self)
    }
}
