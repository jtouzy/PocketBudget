//
//  ExpensesEditorPresenter.swift
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
protocol ExpensesEditorPresenter {
    var didTapAddRelay: PublishRelay<()> { get }
    var didRemoveExpense: PublishRelay<Expense> { get }
    func getItemsDriver() -> Driver<[ExpenseUI]>
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class ExpensesEditorPresenterImpl: ExpensesEditorPresenter {
    weak var view: ExpensesEditorView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared
    lazy var interactor: ExpensesEditorInteractor = ExpensesEditorInteractorImpl()

    let input: ExpensesEditorModuleInput

    let didTapAddRelay = PublishRelay<()>()
    let didRemoveExpense = PublishRelay<Expense>()
    let disposeBag = DisposeBag()

    lazy var emptyViewModelByExpenseType: EmptyViewModel = {
        return EmptyViewModel(
            title: "expenses_editor_\(input.type.rawValue)_empty_title".localized,
            actionTitle: "expenses_editor_\(input.type.rawValue)_empty_action".localized
        )
    }()

    init(view: ExpensesEditorView, with input: ExpensesEditorModuleInput) {
        self.view = view
        self.input = input
        subscribeForNavigateToNewExpenseEditor(didTapAddRelay)
        subscribeForRemoveExpenseAction(didRemoveExpense)
    }

    func getItemsDriver() -> Driver<[ExpenseUI]> {
        return interactor.getExpenses(for: input.accountId, of: input.type)
            .asDriver(onErrorJustReturn: [])
            .do(onNext: { [weak self] in
                guard let self = self else { return }
                self.view?.evaluateEmptiness(for: $0, model: self.emptyViewModelByExpenseType) {
                    $0.emit(to: self.didTapAddRelay).disposed(by: self.disposeBag)
                }
            })
    }
}

//
// MARK: PRESENTER PRIVATE FUNCTIONS
//
extension ExpensesEditorPresenterImpl {
    private func subscribeForNavigateToNewExpenseEditor(_ stream: PublishRelay<()>) {
        stream
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.wireframe.present(
                    module: .newExpenseEditor(
                        input: NewExpenseEditorModuleInput(
                            accountId: self.input.accountId,
                            type: self.input.type
                        )
                    ),
                    options: .automatic
                )
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
