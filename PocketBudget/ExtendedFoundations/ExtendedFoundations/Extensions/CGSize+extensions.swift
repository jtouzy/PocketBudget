//
//  CGSize+extensions.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import CoreGraphics

public extension CGSize {
    static func / (source: CGSize, number: Int) -> CGSize {
        let divider = CGFloat(number)
        return CGSize(width: source.width / divider, height: source.height / divider)
    }
}
