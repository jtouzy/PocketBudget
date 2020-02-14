//
//  RequiredExpensesEditorPresenter.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import RxSwift

//
// MARK: PRESENTER PROTOCOL
//
protocol RequiredExpensesEditorPresenter {
    var didTapAddRelay: PublishRelay<()> { get }
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class RequiredExpensesEditorPresenterImpl: RequiredExpensesEditorPresenter {
    weak var view: RequiredExpensesEditorView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared

    let didTapAddRelay = PublishRelay<()>()
    let disposeBag = DisposeBag()

    init(view: RequiredExpensesEditorView) {
        self.view = view
        subscribeToDidTapAddRelay()
    }
}

//
// MARK: PRESENTER PRIVATE FUNCTIONS
//
extension RequiredExpensesEditorPresenterImpl {
    func subscribeToDidTapAddRelay() {
        didTapAddRelay
            .subscribe(onNext: { _ in
                print("next call")
            })
            .disposed(by: disposeBag)
    }
}
