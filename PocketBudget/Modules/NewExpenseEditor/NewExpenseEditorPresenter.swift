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
    var didTapAddRelay: PublishRelay<NewExpenseFormModel> { get }
    func getButtonActivationConditionObservable() -> Observable<Bool>
}

//
// MARK: PRESENTER IMPLEMENTATION
//
class NewExpenseEditorPresenterImpl: NewExpenseEditorPresenter {
    weak var view: NewExpenseEditorView?
    lazy var wireframe: Wireframe = ApplicationWireframe.shared

    let input: NewExpenseEditorModuleInput

    let didTapAddRelay = PublishRelay<NewExpenseFormModel>()
    let disposeBag = DisposeBag()

    init(view: NewExpenseEditorView, with input: NewExpenseEditorModuleInput) {
        self.view = view
        self.input = input
        subscribeToAddNewExpense(didTapAddRelay)
    }

    func getButtonActivationConditionObservable() -> Observable<Bool> {
        guard let view = view else { return .just(false) }
        return Observable.combineLatest(
            view.titleInputControlProperty.map { !$0.orEmpty.isEmpty },
            view.amountInputControlProperty.map { !$0.orEmpty.isEmpty }
        ) { $0 && $1 }
    }
}

//
// MARK: PRESENTER PRIVATE FUNCTIONS
//
extension NewExpenseEditorPresenterImpl {
    private func subscribeToAddNewExpense(_ stream: PublishRelay<NewExpenseFormModel>) {
        stream
            .subscribe(onNext: { [weak self] formModel in
                guard let self = self else { return }
                // FIXME: Interactor + Real data
                ApplicationStorage.current.add(expense:
                    Expense(
                        id: "",
                        title: formModel.title,
                        amount: Double(formModel.amount) ?? 0,
                        color: formModel.color.asColor,
                        type: self.input.type,
                        accountId: self.input.accountId
                    )
                )
                self.wireframe.close()
            })
            .disposed(by: disposeBag)
    }
}
