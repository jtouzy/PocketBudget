//
//  ApplicationWireframe.swift
//  PocketBudget
//
//  Created by Jérémy TOUZY on 14/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

//
// MARK: WIREFRAME PROTOCOL
//
protocol Wireframe {
    func push(to module: ApplicationModule)
    func present(module: ApplicationModule)
    func close()
}

//
// MARK: WIREFRAME IMPLEMENTATION
//
class ApplicationWireframe: NSObject {
    static let shared = ApplicationWireframe()

    var presentedViewController: UIViewController?
    var topViewControllerInPresented: UIViewController? {
        guard let presented = presentedViewController else { return nil }
        return (presented as? UINavigationController)?.topViewController ?? presented
    }

    func initializeWindow(with windowScene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        presentedViewController = ApplicationModule.accountsEditor.build()
        window.rootViewController = presentedViewController
        window.makeKeyAndVisible()
        return window
    }
}

//
// MARK: WIREFRAME IMPLEMENTATION + PROTOCOL
//
extension ApplicationWireframe: Wireframe {
    func push(to module: ApplicationModule) {
        guard
            let viewController = module.build(),
            let navigationController = presentedViewController as? UINavigationController
        else {
            return
        }
        navigationController.pushViewController(viewController, animated: true)
    }

    func present(module: ApplicationModule) {
        guard let viewController = module.build() else {
            return
        }
        topViewControllerInPresented?.present(viewController, animated: true, completion: nil)
        presentedViewController = viewController
        presentedViewController?.presentationController?.delegate = self
    }

    func close() {
        let parentViewController = presentedViewController?.presentingViewController
        presentedViewController?.dismiss(animated: true, completion: nil)
        presentedViewController = parentViewController
    }
}

//
// MARK: WIREFRAME EXTENSION FOR IOS 13 MODALS
//
extension ApplicationWireframe: UIAdaptivePresentationControllerDelegate {
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        presentedViewController = presentationController.presentingViewController
    }
}
