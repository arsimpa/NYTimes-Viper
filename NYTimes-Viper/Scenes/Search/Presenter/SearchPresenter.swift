//
//  SearchPresenter.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 05/05/2021.
//  
//

import Foundation

class SearchPresenter {

    // MARK: Properties

    weak var view: SearchView?
    var router: SearchWireframe?
    var interactor: SearchUseCase?
}

extension SearchPresenter: SearchPresentation {
    // TODO: implement presentation methods
}

extension SearchPresenter: SearchInteractorOutput {
    // TODO: implement interactor output methods
}
