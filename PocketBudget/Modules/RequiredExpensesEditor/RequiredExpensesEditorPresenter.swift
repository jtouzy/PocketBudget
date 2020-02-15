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
    var didRemoveExpense: PublishRelay<Expense> { get }
    func getItemsDriver() -> Driver<[Expense]>
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class RequiredExpensesEditorPresenterImpl: RequiredExpensesEditorPresenter {
    weak var view: RequiredExpensesEditorView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared
    lazy var interactor: RequiredExpensesEditorInteractor = RequiredExpensesEditorInteractorImpl()

    let didTapAddRelay = PublishRelay<()>()
    let didRemoveExpense = PublishRelay<Expense>()
    let disposeBag = DisposeBag()

    init(view: RequiredExpensesEditorView) {
        self.view = view
        subscribeForNavigateToNewExpenseEditor(didTapAddRelay)
        subscribeForRemoveExpenseAction(didRemoveExpense)
    }

    func getItemsDriver() -> Driver<[Expense]> {
        return interactor.getRequiredExpenses(for: "account_1")
            .asDriver(onErrorJustReturn: [])
            .do(onNext: { [weak self] in
                guard let self = self else { return }
                self.view?.evaluateEmptiness(for: $0) { actionSignal in
                    actionSignal.emit(to: self.didTapAddRelay).disposed(by: self.disposeBag)
                }
            })
    }
}

//
// MARK: PRESENTER PRIVATE FUNCTIONS
//
extension RequiredExpensesEditorPresenterImpl {
    private func subscribeForNavigateToNewExpenseEditor(_ stream: PublishRelay<()>) {
        stream
            .subscribe(onNext: { [weak self] _ in
                self?.wireframe.present(module: .newExpenseEditor)
            })
            .disposed(by: disposeBag)
    }

    private func subscribeForRemoveExpenseAction(_ stream: PublishRelay<Expense>) {
        stream
            .subscribe(onNext: { [weak self] expense in
                self?.interactor.remove(expense: expense)
            })
            .disposed(by: disposeBag)
    }
}
