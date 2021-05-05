//
//  ArticleSettingsRouter.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//  
//

import Foundation
import UIKit

class ArticleSettingsRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ArticleSettingsViewController {
        let viewController = UIStoryboard.loadViewController() as ArticleSettingsViewController
        let presenter = ArticleSettingsPresenter()
        let router = ArticleSettingsRouter()
        let interactor = ArticleSettingsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ArticleSettingsRouter: ArticleSettingsWireframe {
    // TODO: Implement wireframe methods
}
