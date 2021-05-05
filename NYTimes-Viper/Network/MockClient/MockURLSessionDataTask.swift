//
//  MockTask.swift
//  OMWTests
//
//  Created by Arsalan Khan on 10/04/2020.
//  Copyright © 2020 Arsalan Khan. All rights reserved.
//

import Foundation

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    
    private (set) var resumeWasCalled = false
        
    func resume() {
        resumeWasCalled = true
    }
    
}
