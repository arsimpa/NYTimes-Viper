//
//  ArticleListPresenter.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 03/05/2021.
//  
//

import Foundation

class ArticleListPresenter {

    // MARK: Properties

    weak var view: ArticleListView?
    var router: ArticleListWireframe?
    var interactor: ArticleListUseCase?
}

extension ArticleListPresenter: ArticleListPresentation {
    
    func initView() {
        view?.initView()
    }
    
    func loadArticlesFor(period: ArticlePeriod) {
        
        view?.showLoading()
        interactor?.fetchArticlesFor(period: period)
    }
}

extension ArticleListPresenter: ArticleListInteractorOutput {
    
    func articleFetchFailed(_ err: Error) {
        view?.hideLoading()
        view?.displayError(ArticleViewModel.FetchError(message: err.localizedDescription, title: "Error"))
    }
    
    
    func fetchedArticles(articles: [Article]) {
            
        view?.hideLoading()
        view?.displayArticles(convertArtilesToViewModel(articles: articles))
    }
    
    func convertArtilesToViewModel(articles: [Article]) -> [ArticleViewModel.ViewModel] {
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        let viewModels: [ArticleViewModel.ViewModel] = articles.map { art in
            
            let date = dateformatter.date(from: art.updated) ?? Date()
            dateformatter.dateStyle = .short
            
            let thumbNailImage = art.media.first?.mediaMetadata.filter { $0.format == MediaMetaDataFormat.mediumThreeByTwo210.rawValue }.first
            
            return ArticleViewModel.ViewModel(id: art.id, title: art.title, abstract: art.abstract ,author: art.byline, date: "Published on: \(dateformatter.string(from: date))", section: art.section, thumbnailImage: thumbNailImage?.url ?? "")
        }
        
        return viewModels
    }
}
