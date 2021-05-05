//
//  RequestCaching.swift
//  Classify
//
//  Created by Arsalan Khan on 19/02/2021.
//

import Foundation

protocol RequestCache {
    
    func cachedResponse(for request: URLRequest) -> CachedURLResponse?
    func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest)
    
    func removeCachedResponse(for request: URLRequest)
    func removeAllCachedResponses()
}

extension URLCache : RequestCache {}


// Wrapper class to abstract System level information
class MyCacheWrapper {
    
    let cache: RequestCache
    
    required init(_ cache: RequestCache = URLCache.shared) {
        self.cache = cache
    }
    
}
