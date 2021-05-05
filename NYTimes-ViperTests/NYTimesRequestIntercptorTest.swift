//
//  NYTimesRequestIntercptorTest.swift
//  NYTimes-ViperTests
//
//  Created by Arsalan Khan on 04/05/2021.
//

import XCTest
@testable import NYTimes_Viper

class NYTimesRequestIntercptorTest: XCTestCase {

    var interceptor: NYTimesAPIKeyInterceptor!
    
    override func setUpWithError() throws {
        interceptor = NYTimesAPIKeyInterceptor()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPIKeyAdded() throws {
        
        var request = URLRequest(baseUrl: BASE_URL, path: "svc/mostpopular/v2/viewed/1.json", method: .get, params: [:])
        interceptor.adapt(&request, in: MockURLSession())
        
        let queryParams = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
        
        XCTAssertNotNil(queryParams!.queryItems!.contains(URLQueryItem(name: "api-key", value: "9bTSpVujOOfeQSSCqWi2WDpAvuhI3c4d")))
    }
    
    func testCorrectAPIKey() throws {
        
        var request = URLRequest(baseUrl: BASE_URL, path: "svc/mostpopular/v2/viewed/1.json", method: .get, params: [:])
        interceptor.adapt(&request, in: MockURLSession())
        
        let queryParams = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
        
        XCTAssertTrue(queryParams!.queryItems!.contains(URLQueryItem(name: "api-key", value: "9bTSpVujOOfeQSSCqWi2WDpAvuhI3c4d")))
    }
    
    func testWrongAPIKey() throws {
        
        var request = URLRequest(baseUrl: BASE_URL, path: "svc/mostpopular/v2/viewed/1.json", method: .get, params: [:])
        interceptor.adapt(&request, in: MockURLSession())
        
        let queryParams = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
        
        XCTAssertFalse(queryParams!.queryItems!.contains(URLQueryItem(name: "api-key", value: "wrongKey")))
    }

}
