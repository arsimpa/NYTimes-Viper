//
//  ArticleListInteractor.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 03/05/2021.
//  
//

import Foundation

protocol ArticleDataStore {
    var datasource: [Article]? { get set }
}

class ArticleListInteractor {

    // MARK: Properties

    weak var output: ArticleListInteractorOutput?
    
    var task: URLSessionDataTask? = nil
    
    var datasource: [Article]? = nil
}

extension ArticleListInteractor: ArticleListUseCase {
    
    func fetchArticlesFor(period: ArticlePeriod) {
        
        let client = HttpClient(baseUrl: BASE_URL)
        
        task?.cancel()
        
        task = ArticleListFetchWorker(client: client).fetchArticles(period) { [unowned self] (resp, err) in
            
            guard err == nil else {
                output?.articleFetchFailed(err!)
                return
            }
            
            guard let resp = resp else {
                output?.articleFetchFailed(ServiceError.custom("No articles fetched"))
                return
            }
            
            guard resp.numResults > 0 else {
                output?.articleFetchFailed(ServiceError.custom("Articles count == \(resp.numResults)"))
                return
            }
            
            datasource = resp.results
            
            output?.fetchedArticles(articles: resp.results)
            
        }
        
    }
    
}

extension ArticleListInteractor: ArticleDataStore {}
