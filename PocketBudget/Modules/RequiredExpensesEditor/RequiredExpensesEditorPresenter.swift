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
    func getItemsDriver() -> Driver<[Expense]>
    var didTapAddRelay: PublishRelay<()> { get }
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class RequiredExpensesEditorPresenterImpl: RequiredExpensesEditorPresenter {
    weak var view: RequiredExpensesEditorView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared
    lazy var interactor: RequiredExpensesEditorInteractor = RequiredExpensesEditorInteractorImpl()

    let didTapAddRelay = PublishRelay<()>()
    let disposeBag = DisposeBag()

    init(view: RequiredExpensesEditorView) {
        self.view = view
        subscribeToDidTapAddRelay()
    }

    func getItemsDriver() -> Driver<[Expense]> {
        return interactor.getRequiredExpenses(for: "account_1").asDriver(onErrorJustReturn: [])
    }
}

//
// MARK: PRESENTER PRIVATE FUNCTIONS
//
extension RequiredExpensesEditorPresenterImpl {
    private func subscribeToDidTapAddRelay() {
        didTapAddRelay
            .subscribe(onNext: { [weak self] _ in
                self?.interactor.add(expense:
                    Expense(id: "new_1", title: "new", accountId: "account_1")
                )
            })
            .disposed(by: disposeBag)
    }
}
