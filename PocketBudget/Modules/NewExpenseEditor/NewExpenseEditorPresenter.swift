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

    let didTapAddRelay = PublishRelay<NewExpenseFormModel>()
    let disposeBag = DisposeBag()

    init(view: NewExpenseEditorView) {
        self.view = view
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
            .subscribe(onNext: { formModel in
                // FIXME: Interactor + Real data
                ApplicationStorage.current.add(expense:
                    Expense(id: "", title: formModel.title, accountId: "account_1")
                )
                self.wireframe.close()
            })
            .disposed(by: disposeBag)
    }
}
