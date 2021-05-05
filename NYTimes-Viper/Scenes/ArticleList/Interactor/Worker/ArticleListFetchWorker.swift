//
//  ArticleListFetchWorker.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 04/05/2021.
//

import Foundation

final class ArticleListFetchWorker {
    
    private var client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    
    @discardableResult
    func fetchArticles(_ period: ArticlePeriod = SettingsManager.shared.settings.selectedPeriod, completion: @escaping (ArticleResponse?, ServiceError?) -> ()) -> URLSessionDataTask? {
                
        return client.request(path: "svc/mostpopular/v2/viewed/\(period.rawValue).json", method: .get, params: [:], adapters: [NYTimesAPIKeyInterceptor()]) { result, error in
            
            guard error == nil else {
                completion(nil, error!)
                return
            }
            
            if let data = result as? Data {
            
                let newJSONDecoder = JSONDecoder()
                
                do {
                    let json = try newJSONDecoder.decode(ArticleResponse.self, from: data)
                    completion(json , error)
                } catch (let err) {
                    completion(nil, ServiceError.custom(err.localizedDescription))
                }
                
            }
        } as? URLSessionDataTask
    }
}
