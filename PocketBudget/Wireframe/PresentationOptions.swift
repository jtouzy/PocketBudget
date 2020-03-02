//
//  PresentationOptions.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 02/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

enum PresentationOptions {
    case automatic
    case fullScreen(transitionAnimations: Bool)

    var modalPresentationStyle: UIModalPresentationStyle {
        switch self {
        case .automatic:
            return .automatic
        case .fullScreen:
            return .fullScreen
        }
    }

    var isTransitionAnimationsEnabled: Bool {
        switch self {
        case .automatic:
            return false
        case .fullScreen(let transitionAnimations):
            return transitionAnimations
        }
    }
}
