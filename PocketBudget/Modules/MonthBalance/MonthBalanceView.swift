//
//  MonthBalanceView.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 20/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

//
// MARK: VIEW SPECS
//
struct MonthBalanceSpecs {
    static let amountTopSpacing: CGFloat = 16
    static let labelsSpacing: CGFloat = 4
    static let settingsStartTrailingDistance: CGFloat = 30
    static let settingsEndTrailingDistance: CGFloat = -16
    static let settindsAndLabelAnimationDuration: TimeInterval = 0.2
    static let tableViewAnimationDuration: TimeInterval = 0.5
}
private typealias Specs = MonthBalanceSpecs

//
// MARK: VIEW PROTOCOL
//
protocol MonthBalanceView: class, UIEmptiable {
}

//
// MARK: VIEW CONTROLLER
//
class MonthBalanceViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.alpha = 0
            tableView.registerNib(MonthBalanceCell.self)
            tableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    var estimatedAmountPresentationLabel: Label?
    var estimatedAmountLabel: Label?
    var emptyView: EmptyView?
    var settingsAccessor: FloatingButton?
    var settingsAccessorTrailingConstraint: NSLayoutConstraint?

    let disposeBag = DisposeBag()
    var presenter: MonthBalancePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        createBindings()
        makeAppearanceAnimations()
    }
}

//
// MARK: PRIVATE CREATION FUNCTIONS
//
extension MonthBalanceViewController {
    private func createPresentationLabel() {
        guard let estimatedAmountLabel = estimatedAmountLabel else { return }
        let presentationLabel = Label(frame: .zero, font: AppFont.font(fromStyle: .footnote))
        presentationLabel.text = "month_balance_estimated_amount_title".localized
        presentationLabel.textColor = .materialGrey
        presentationLabel.alpha = 0
        presentationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(presentationLabel)
        NSLayoutConstraint.activate([
            presentationLabel.centerXAnchor.constraint(
                equalTo: view.centerXAnchor
            ),
            presentationLabel.topAnchor.constraint(
                equalTo: estimatedAmountLabel.bottomAnchor, constant: Specs.labelsSpacing
            )
        ])
        self.estimatedAmountPresentationLabel = presentationLabel
    }

    private func createSettingsAccessor() {
        guard let presenter = presenter, let estimatedAmountLabel = estimatedAmountLabel else { return }
        let settingsAccessor = FloatingButton(frame: .zero, image: "pencil")
        settingsAccessor.alpha = 0
        settingsAccessor.hero.id = AccountSettingsSpecs.viewAnimationId
        settingsAccessor.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(settingsAccessor)
        let trailingConstraint = settingsAccessor.trailingAnchor.constraint(
            equalTo: view.trailingAnchor, constant: Specs.settingsStartTrailingDistance
        )
        NSLayoutConstraint.activate([
            settingsAccessor.topAnchor.constraint(equalTo: estimatedAmountLabel.topAnchor),
            settingsAccessor.heightAnchor.constraint(equalTo: estimatedAmountLabel.heightAnchor),
            settingsAccessor.widthAnchor.constraint(equalTo: estimatedAmountLabel.heightAnchor),
            trailingConstraint
        ])
        view.layoutIfNeeded()
        settingsAccessor.rx.tap
            .asSignal()
            .emit(to: presenter.didTapGoToSettingsRelay)
            .disposed(by: disposeBag)
        self.settingsAccessor = settingsAccessor
        self.settingsAccessorTrailingConstraint = trailingConstraint
    }
}

//
// MARK: PRIVATE ANIMATION FUNCTIONS
//
extension MonthBalanceViewController {
    private func makeAppearanceAnimations() {
        makeAmountAnimation { [weak self] in
            guard let self = self else { return }
            self.createPresentationLabel()
            self.createSettingsAccessor()
            self.makeSettingsAccessorAndPresentationLabelAnimation {
                self.makeTableViewAnimation()
            }
        }
    }

    private func makeAmountAnimation(completion: @escaping () -> Void) {
        estimatedAmountLabel = Label(frame: .zero, font: AppFont.font(fromStyle: .title1))
        estimatedAmountLabel?.text = "AmointText"
        estimatedAmountLabel?.fromCenterToTop(
            in: view,
            topDistance: Specs.amountTopSpacing,
            completion: completion
        )
    }

    private func makeSettingsAccessorAndPresentationLabelAnimation(completion: @escaping () -> Void) {
        settingsAccessorTrailingConstraint?.constant = Specs.settingsEndTrailingDistance
        UIView.animate(withDuration: Specs.settindsAndLabelAnimationDuration, animations: { [weak self] in
            guard let self = self else { return }
            self.estimatedAmountPresentationLabel?.alpha = 1
            self.settingsAccessor?.alpha = 1
            self.view.layoutIfNeeded()
        }, completion: { _ in completion() })
    }

    private func makeTableViewAnimation() {
        guard let estimatedAmountPresentationLabel = self.estimatedAmountPresentationLabel else { return }
        tableViewTopConstraint.isActive = false
        tableView.topAnchor.constraint(equalTo: estimatedAmountPresentationLabel.bottomAnchor, constant: 16).isActive = true
        UIView.animate(withDuration: Specs.tableViewAnimationDuration) { [weak self] in
            self?.tableView.alpha = 1
        }
    }
}

//
// MARK: PRIVATE BINDINGS CREATION FUNCTIONS
//
extension MonthBalanceViewController {
    private func createBindings() {
        createTableViewBinding()
    }

    private func createTableViewBinding() {
        guard let presenter = presenter else { return }
        // Content driving
        tableView.bindContent(with: presenter.getItemsDriver(), cell: MonthBalanceCell.self) {
            $1.configure(transaction: $0)
            // $1.imageView?.image = UIImage(systemName: "number.circle.fill")
            // $1.imageView?.tintColor = $0.color
            // $1.detailTextLabel?.text = String($0.amount)
        }.disposed(by: disposeBag)
        // Actions
        // tableView.bindDeletion(to: presenter.didRemoveExpense).disposed(by: disposeBag)
    }
}

//
// MARK: VIEW CONTROLLER + PROTOCOL
//
extension MonthBalanceViewController: MonthBalanceView {
}
