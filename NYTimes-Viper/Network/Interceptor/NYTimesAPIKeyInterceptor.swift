//
//  RequestInterceptor.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 04/05/2021.
//

import Foundation

class NYTimesAPIKeyInterceptor: RequestAdapter {
    
    let APIKEY = "9bTSpVujOOfeQSSCqWi2WDpAvuhI3c4d"
    
    func adapt(_ urlRequest: inout URLRequest, in session: URLSessionProtocol) {
                
        if let urlStr = urlRequest.url?.absoluteString {
            
            let queryItem = URLQueryItem(name: "api-key", value: APIKEY)
            var queryComp = URLComponents(string: urlStr)
            queryComp?.queryItems?.append(queryItem)
            
            urlRequest.url = queryComp?.url
        }
        
    }
    
}
