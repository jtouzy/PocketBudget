//
//  ColorSelector.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class ColorSelector: UIView {
    var collectionView: UICollectionView?

    let selectedColorRelay = BehaviorRelay<UIColor>(value: UIColor.materialColors.first ?? .clear)
    let disposeBag = DisposeBag()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        clipsToBounds = false
        drawCollectionView()
    }

    private func drawCollectionView() {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.clipsToBounds = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(
            ColorSelectorCell.self,
            forCellWithReuseIdentifier: ColorSelectorCell.identifier
        )
        collectionView.addTo(view: self)
        configureBindings(for: collectionView)
        self.collectionView = collectionView
    }

    private func configureBindings(for collectionView: UICollectionView) {
        // Cell contents
        selectedColorRelay.asObservable()
            .withLatestFrom(Observable.just(UIColor.materialColors)) { selected, colors in
                return colors.map {
                    ColorSelectorCell.Model(color: $0, isSelected: $0 == selected)
                }
            }
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(
                cellIdentifier: ColorSelectorCell.identifier, cellType: ColorSelectorCell.self)
            ) {
                $2.configure(for: $1)
            }
            .disposed(by: disposeBag)
        // Cell tap
        collectionView.rx.modelSelected(ColorSelectorCell.Model.self)
            .subscribe(onNext: { [weak self] in
                self?.selectedColorRelay.accept($0.color)
            })
            .disposed(by: disposeBag)
    }
}
