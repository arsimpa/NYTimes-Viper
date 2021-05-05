//
//  ArticleListContract.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 03/05/2021.
//  
//

import Foundation

enum ArticlePeriod: Int, Codable {
    
    case oneDay = 1
    case sevenDay = 7
    case thirtyDays = 30
    
    var title: String {
        switch self {
        case .oneDay:
            return "One Day"
        case .sevenDay:
            return "Seven Days"
        case .thirtyDays:
            return "Thirty Days"
        }
    }
    
    static var allPeriods : [ArticlePeriod] {
        return [.oneDay, sevenDay, thirtyDays]
    }
}

protocol ArticleListView: class {
    func initView()
    func showLoading()
    func hideLoading()
    func displayError(_ err: ArticleViewModel.FetchError)
    func displayArticles(_ articles: [ArticleViewModel.ViewModel])
}

protocol ArticleListPresentation: class {
    func initView()
    func loadArticlesFor(period: ArticlePeriod)
}

protocol ArticleListUseCase: class {
    func fetchArticlesFor(period: ArticlePeriod)
}

protocol ArticleListInteractorOutput: class {
    func fetchedArticles(articles: [Article])
    func articleFetchFailed(_ err: Error)
}

protocol ArticleListWireframe: class {
    // TODO: Declare wireframe methods
}
