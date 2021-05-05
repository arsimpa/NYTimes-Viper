//
//  ArticleListRouter.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 03/05/2021.
//  
//

import Foundation
import UIKit

class ArticleListRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> ArticleListViewController {
        let viewController = UIStoryboard.loadViewController() as ArticleListViewController
        let presenter = ArticleListPresenter()
        let router = ArticleListRouter()
        let interactor = ArticleListInteractor()

        viewController.listPresenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension ArticleListRouter: ArticleListWireframe {
    // TODO: Implement wireframe methods
}
