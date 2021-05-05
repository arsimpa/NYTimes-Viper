//
//  ArticleViewModel.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 04/05/2021.
//

import Foundation

struct ArticleViewModel {
    
    struct Response {
        let articleResponse: ArticleResponse
    }
    
    struct FetchError {
        let message: String
        let title: String
    }
    
    struct ViewModel {
        
        let id: Int
        let title: String
        let abstract: String
        let author: String
        let date: String
        let section: String
        let thumbnailImage: String
        
    }
}
