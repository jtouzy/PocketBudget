//
//  NewExpenseEditorPresenter.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 15/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxRelay
import RxSwift

//
// MARK: PRESENTER PROTOCOL
//
protocol NewExpenseEditorPresenter {
    var didTapAddRelay: PublishRelay<()> { get }
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class NewExpenseEditorPresenterImpl: NewExpenseEditorPresenter {
    weak var view: NewExpenseEditorView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared

    let didTapAddRelay = PublishRelay<()>()
    let disposeBag = DisposeBag()

    init(view: NewExpenseEditorView) {
        self.view = view
        subscribeToAddNewExpense(didTapAddRelay)
    }
}

//
// MARK: PRESENTER PRIVATE FUNCTIONS
//
extension NewExpenseEditorPresenterImpl {
    private func subscribeToAddNewExpense(_ stream: PublishRelay<()>) {
        stream
            .subscribe(onNext: {
                // FIXME: Interactor + Real data
                ApplicationStorage.current.add(expense:
                    Expense(id: "id", title: "title", accountId: "account_1")
                )
                self.wireframe.close()
            })
            .disposed(by: disposeBag)
    }
}
