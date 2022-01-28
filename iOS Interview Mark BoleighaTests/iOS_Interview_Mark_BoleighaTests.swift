//
//  iOS_Interview_Mark_BoleighaTests.swift
//  iOS Interview Mark BoleighaTests
//
//  Created by Mark Boleigha on 14/01/2022.
//  Copyright © 2022 Umba. All rights reserved.
//

import XCTest
import CoreData
@testable import iOS_Interview_Mark_Boleigha

class iOS_Interview_Mark_BoleighaTests: XCTestCase {

    var viewModel: HomeViewModel!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        HTTP.shared.service = MockRequest()
        viewModel = HomeViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.clearStorage()
    }
    
    func testPopular() {
        
        let expectation = XCTestExpectation()
        
        viewModel.loadVideos(category: .popular) {
            XCTAssertTrue(self.viewModel.popular.count > 1)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 7)
    }
    
    func testUpcoming() {
        
        let expectation = XCTestExpectation()
        
        viewModel.loadVideos(category: .upcoming) {
            XCTAssertTrue(self.viewModel.upcoming.count > 1)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 7)
    }
    
    func testSaveToDB() {
        let expectation = XCTestExpectation()
        let context = AppDelegate.shared.persistentContainer.viewContext
        
        viewModel.loadVideos(category: .upcoming) {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieResponse")
            //request.predicate = NSPredicate(format: "age = %@", "12")
            request.returnsObjectsAsFaults = false

            do {
                let result = try context.fetch(request)
                XCTAssertNotNil(result)
                XCTAssertTrue(result.count > 0)
            } catch {
                print("Failed")
            }
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    private func clearStorage() {
        let context = AppDelegate.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieResponse")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }

}
