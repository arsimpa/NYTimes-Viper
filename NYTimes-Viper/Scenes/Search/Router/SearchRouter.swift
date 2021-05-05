//
//  SearchRouter.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//  
//

import Foundation
import UIKit

class SearchRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> SearchViewController {
        let viewController = UIStoryboard.loadViewController() as SearchViewController
        let presenter = SearchPresenter()
        let router = SearchRouter()
        let interactor = SearchInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension SearchRouter: SearchWireframe {
    // TODO: Implement wireframe methods
}
