//
//  RequiredExpensesEditorView.swift
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
protocol RequiredExpensesEditorView: class {
}

//
// MARK: VIEW CONTROLLER
//
class RequiredExpensesEditorViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.register(UITableViewCell.self,
                               forCellReuseIdentifier: UITableViewCell.identifier)
        }
    }
    @IBOutlet weak var addButton: UIButton!

    let disposeBag = DisposeBag()
    var presenter: RequiredExpensesEditorPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        createBindings()
    }
}

//
// MARK: PRIVATE BINDINGS CREATION FUNCTIONS
//
extension RequiredExpensesEditorViewController {
    private func createBindings() {
        createTableViewBinding()
        createAddButtonBinding()
    }

    private func createTableViewBinding() {
        guard let presenter = presenter else { return }
        presenter.getItemsDriver()
            .drive(tableView.rx.items(cellIdentifier: "UITableViewCell",
                                      cellType: UITableViewCell.self)) { (_, expense, cell) in
                cell.textLabel?.text = expense.title
            }
            .disposed(by: disposeBag)
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
extension RequiredExpensesEditorViewController: RequiredExpensesEditorView {
}
