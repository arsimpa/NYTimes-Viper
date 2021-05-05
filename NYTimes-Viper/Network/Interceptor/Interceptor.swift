//
//  Interceptor.swift
//  NYTimes-Viper
//
//  Created by Arsalan Khan on 04/05/2021.
//

import Foundation

protocol RequestAdapter {
    func adapt(_ urlRequest: inout URLRequest, in session: URLSessionProtocol)
}

protocol ResponseParser {
    func parse(_ response: URLResponse, for request: URLRequest, in session: URLSessionProtocol)
}
