//
//  ColorSelectorCell.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import ExtendedFoundations
import UIKit

private struct Constants {
    struct animation {
        static let activeTransform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        static let baseTransform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        static let enterDuration = 0.2
        static let exitDuration = 0.2
    }
}

class ColorSelectorCell: UICollectionViewCell {
    typealias Model = (color: UIColor, isSelected: Bool)

    var colorView: UIView?
    var imageView: UIImageView?

    func configure(for model: ColorSelectorCell.Model) {
        if colorView != nil {
            applyModelToView(model)
        } else {
            createColorView(with: model)
        }
    }

    private func createColorView(with model: ColorSelectorCell.Model) {
        let colorView = UIView()
        colorView.layer.cornerRadius = frame.width / 2
        colorView.addTo(view: self)
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")
        imageView.tintColor = .white
        imageView.addToCenter(of: colorView, sized: frame.size / 2)
        self.colorView = colorView
        self.imageView = imageView
        applyModelToView(model)
    }

    private func applyModelToView(_ model: ColorSelectorCell.Model) {
        colorView?.backgroundColor = model.color
        imageView?.alpha = 0
        if model.isSelected {
            animateSelection()
        }
    }

    private func animateSelection() {
        UIView.animate(withDuration: Constants.animation.enterDuration, animations: { [weak self] in
            self?.colorView?.transform = Constants.animation.activeTransform
            self?.imageView?.transform = Constants.animation.activeTransform
            self?.imageView?.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: Constants.animation.exitDuration) { [weak self] in
                self?.colorView?.transform = Constants.animation.baseTransform
                self?.imageView?.transform = Constants.animation.baseTransform
            }
        })
    }
}
