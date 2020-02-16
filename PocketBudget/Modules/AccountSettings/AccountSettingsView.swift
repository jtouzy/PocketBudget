//
//  AccountSettingsView.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

//
// MARK: VIEW PROTOCOL
//
protocol AccountSettingsView: class {
}

//
// MARK: VIEW CONTROLLER
//
class AccountSettingsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }

    let disposeBag = DisposeBag()
    var presenter: AccountSettingsPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        createBindings()
    }
}

//
// MARK: PRIVATE BINDINGS CREATION FUNCTIONS
//
extension AccountSettingsViewController {
    private func createBindings() {
        createTableViewBinding()
    }

    private func createTableViewBinding() {
        guard let presenter = presenter else { return }
        // Elements driving
        presenter.itemsDriver
            .drive(tableView.rx.items(cellIdentifier: "UITableViewCell",
                                      cellType: UITableViewCell.self)) { (_, item, cell) in
                cell.textLabel?.text = item.title
                cell.detailTextLabel?.text = item.subtitle
            }
            .disposed(by: disposeBag)
        // Deleting signal
        tableView.rx.modelSelected(AccountSettingsItem.self)
            .asSignal()
            .emit(to: presenter.didSelectSettingsItem)
            .disposed(by: disposeBag)
    }
}

//
// MARK: VIEW CONTROLLER + PROTOCOL
//
extension AccountSettingsViewController: AccountSettingsView {
}
