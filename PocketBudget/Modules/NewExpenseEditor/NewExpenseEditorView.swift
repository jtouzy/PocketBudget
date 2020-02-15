//
//  NewExpenseEditorView.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 15/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

//
// MARK: VIEW PROTOCOL
//
protocol NewExpenseEditorView: class {
    var titleInputControlProperty: ControlProperty<String?> { get }
    var amountInputControlProperty: ControlProperty<String?> { get }
}

//
// MARK: VIEW CONTROLLER
//
class NewExpenseEditorViewController: ModalViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var expenseTitleTextField: UITextField!
    @IBOutlet weak var expenseAmountTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!

    let disposeBag = DisposeBag()
    var presenter: NewExpenseEditorPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        createBindings()
        expenseTitleTextField.becomeFirstResponder()
    }
}

//
// MARK: PRIVATE BINDINGS CREATION FUNCTIONS
//
extension NewExpenseEditorViewController {
    private func createBindings() {
        createAddButtonBindings()
    }

    private func createAddButtonBindings() {
        createAddButtonTapEventBinding()
        createAddButtonActivationBinding()
    }

    private func createAddButtonTapEventBinding() {
        guard let presenter = presenter else { return }
        addButton.rx.tap
            .map {
                NewExpenseFormModel(
                    title: self.expenseTitleTextField.text.orEmpty,
                    amount: self.expenseAmountTextField.text.orEmpty
                )
            }
            .asSignal(onErrorJustReturn: (title: "", amount: ""))
            .emit(to: presenter.didTapAddRelay)
            .disposed(by: disposeBag)
    }

    private func createAddButtonActivationBinding() {
        guard let presenter = presenter else { return }
        presenter.getButtonActivationConditionObservable()
            .bind(to: addButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
}

//
// MARK: VIEW CONTROLLER + PROTOCOL
//
extension NewExpenseEditorViewController: NewExpenseEditorView {
    var titleInputControlProperty: ControlProperty<String?> {
        return expenseTitleTextField.rx.text
    }
    var amountInputControlProperty: ControlProperty<String?> {
        return expenseAmountTextField.rx.text
    }
}
