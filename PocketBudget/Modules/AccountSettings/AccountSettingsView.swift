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
// MARK: VIEW SPECS
//
struct AccountSettingsSpecs {
    static let viewAnimationId = "accountSettingsView"
}

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
        view.hero.id = AccountSettingsSpecs.viewAnimationId
        createBindings()
    }
}

//
// MARK: PRIVATE BINDINGS CREATION FUNCTIONS
//
extension AccountSettingsViewController {
    private func createBindings() {
        createViewTitleBinding()
        createNavBarBinding()
        createTableViewBinding()
    }

    private func createViewTitleBinding() {
        guard let presenter = presenter else { return }
        presenter.getSettingsTitle()
            .subscribe(onNext: { [weak self] title in
                self?.navigationItem.title = title
            })
            .disposed(by: disposeBag)
    }

    private func createNavBarBinding() {
        guard let presenter = presenter else { return }
        let closeButton = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up"), style: .done, target: nil, action: nil
        )
        navigationItem.rightBarButtonItem = closeButton
        closeButton.rx.tap
            .asSignal()
            .emit(to: presenter.didTapCloseRelay)
            .disposed(by: disposeBag)
    }

    private func createTableViewBinding() {
        guard let presenter = presenter else { return }
        // Content driving
        tableView.bindContent(with: presenter.itemsDriver, cell: UITableViewCell.self) {
            $1.imageView?.image = UIImage(systemName: $0.systemImageName)
            $1.imageView?.tintColor = $0.systemImageColor
            $1.textLabel?.text = $0.title
            $1.detailTextLabel?.text = $0.subtitle
        }.disposed(by: disposeBag)
        // Actions
        tableView.bindSelection(to: presenter.didSelectSettingsItem).disposed(by: disposeBag)
    }
}

//
// MARK: VIEW CONTROLLER + PROTOCOL
//
extension AccountSettingsViewController: AccountSettingsView {
}
