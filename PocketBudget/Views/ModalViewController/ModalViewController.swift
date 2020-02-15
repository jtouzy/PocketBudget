//
//  ModalViewController.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 15/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

private struct Constants {
    static let cornerRadius: CGFloat = 20
    static let alpha: CGFloat = 0.4
    struct LayerAnimation {
        static let enterDuration = 0.3
        static let enterDelay = 0.3
        static let exitDuration = 0.1
    }
    struct Shadow {
        static let color: CGColor = UIColor.gray.cgColor
        static let opacity: Float = 1
        static let offset: CGSize = .zero
        static let radius: CGFloat = 10
    }
}

class ModalViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var layerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        createModalView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: Constants.LayerAnimation.enterDuration,
                       delay: Constants.LayerAnimation.enterDelay,
                       options: .curveEaseInOut, animations: { [weak self] in
            self?.layerView.alpha = Constants.alpha
        })
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: Constants.LayerAnimation.exitDuration,
                       animations: { [weak self] in self?.layerView.alpha = 0 },
                       completion: { [weak self] _ in
            self?.dismissWithoutLayerAnimation(animated: flag, completion: completion)
        })
    }
}

extension ModalViewController {
    private func createModalView() {
        layerView.alpha = 0
        contentView.layer.cornerRadius = Constants.cornerRadius
        contentView.layer.shadowColor = Constants.Shadow.color
        contentView.layer.shadowOpacity = Constants.Shadow.opacity
        contentView.layer.shadowOffset = Constants.Shadow.offset
        contentView.layer.shadowRadius = Constants.Shadow.radius
        contentView.layer.shadowPath = UIBezierPath(
            roundedRect: contentView.bounds,
            cornerRadius: contentView.layer.cornerRadius
        ).cgPath
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
    }

    private func dismissWithoutLayerAnimation(animated flag: Bool, completion: (() -> Void)?) {
        super.dismiss(animated: flag, completion: completion)
    }
}
