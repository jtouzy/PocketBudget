//
//  ExpensesEditorView.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

//
// MARK: VIEW PROTOCOL
//
protocol ExpensesEditorView: class, UIEmptiable {
}

//
// MARK: VIEW CONTROLLER
//
class ExpensesEditorViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var addButton: UIButton!
    var emptyView: EmptyView?

    let disposeBag = DisposeBag()
    var presenter: ExpensesEditorPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        createBindings()
    }
}

//
// MARK: PRIVATE BINDINGS CREATION FUNCTIONS
//
extension ExpensesEditorViewController {
    private func createBindings() {
        createTableViewBinding()
        createAddButtonBinding()
    }

    private func createTableViewBinding() {
        guard let presenter = presenter else { return }
        // Content driving
        tableView.bindContent(with: presenter.getItemsDriver(), cell: UITableViewCell.self) {
            $1.textLabel?.text = $0.title
            $1.imageView?.image = UIImage(systemName: "number.circle.fill")
            $1.imageView?.tintColor = $0.color
            $1.detailTextLabel?.text = $0.amount
        }.disposed(by: disposeBag)
        // Actions
        tableView.bindDeletion(to: presenter.didRemoveExpense).disposed(by: disposeBag)
    }

    private func createAddButtonBinding() {
        guard let presenter = presenter else { return }
        addButton.rx.tap
            .asSignal()
            .emit(to: presenter.didTapAddRelay)
            .disposed(by: disposeBag)
    }
}

//
// MARK: VIEW CONTROLLER + PROTOCOL
//
extension ExpensesEditorViewController: ExpensesEditorView {
}
