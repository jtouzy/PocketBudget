//
//  FloatingButton.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 02/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

class FloatingButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    init(frame: CGRect, image: String? = nil) {
        super.init(frame: frame)
        configure(with: image)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.width / 2
    }
}

private extension FloatingButton {
    func configure(with image: String? = nil) {
        if let image = image {
            setImage(UIImage(systemName: image), for: .normal)
        }
        backgroundColor = .materialTeal
        tintColor = .white
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
    }
}
