//
//  Color.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 17/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import CoreGraphics

class Color: Codable {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat

    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}
