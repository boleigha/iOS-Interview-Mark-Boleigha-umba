//
//  NetworkLayerTests.swift
//  iOS Interview Mark Boleigha
//
//  Created by Mark Boleigha on 17/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//


import XCTest
@testable import iOS_Interview_Mark_Boleigha

class NetworkLayerTests: XCTestCase {
    
    var request: HTTP!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        request = HTTP.shared
        request.service = MockRequest()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHeaderAuthorization() {
        let sampleKey = "1cc8f99171185fdfe94575"
        let headers = request.buildRequestHeaders(encoding: .json, apiKey: "1cc8f99171185fdfe94575")
        
        XCTAssertTrue(headers.contains(.authorization(sampleKey)), "Request contains an API key")
    }
    
    func testRequestContainsAPIKey() {
        guard let api_key = Bundle.main.infoDictionary?["API"] as? String else {
            XCTFail("No valid API key found in config")
            return
        }
        
        let testURL = API.auth(.request_token)
        
        XCTAssertTrue(testURL.stringValue.contains("?api_key=\(api_key)"), "API key is being sent with request")
    }
    
    
    func testURLContainsBase() {
        
    }
    
}
