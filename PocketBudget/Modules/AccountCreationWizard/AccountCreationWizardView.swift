//
//  AccountCreationWizardViewController.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 16/03/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: VIEW PROTOCOL
//
protocol AccountCreationWizardView: class {
}

//
// MARK: VIEW CONTROLLER
//
class AccountCreationWizardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleTextAttributes = [
            NSAttributedString.Key.font: AppFont.font(fromStyle: .title2) as Any
        ]
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
}
