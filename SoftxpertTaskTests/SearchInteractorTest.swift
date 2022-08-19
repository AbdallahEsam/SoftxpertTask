//
//  SearchInteractorTest.swift
//  SoftxpertTaskTests
//
//  Created by Abdallah Essam on 18/08/2022.
//  Copyright © 2022 Abdallah Essam. All rights reserved.
//


import XCTest
@testable import SoftxpertTask

class SearchInteractorTest: XCTestCase {
    
    var sut: SearchInteractor!
    var repo: MainRepoMock!
    var presenter: SearchPresenterSpy!
    override func setUp() {
        super.setUp()
        repo = .init()
        presenter = .init()
        sut = .init(repo: repo, presenter: presenter)
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
        repo = nil
        presenter = nil
    }
    
    
    func testSearchInteractor_whenSearchApiCalled_willCallSearchApiInRepo(){
        
        // Given
       
        // When
        sut.search(searchKey: "s", filter: nil, from: 0)
        // Then
        XCTAssertTrue(repo.isSearchApiCalled)
    }
    
    
    func testSearchInteractor_whenSearchApiCalled_willCallFetchDataSuccessfully(){
        
        // Given
       
        // When
        sut.search(searchKey: "s", filter: nil, from: 0)
        repo.simulateGettingSearchSuccessResponse()
        // Then
        XCTAssertTrue(presenter.isFetchDataSuccessfullyCalled)
    }
    
    
    func testSearchInteractor_whenSearchApiCalled_willCallFetchError(){
        
        // Given
       
        // When
        sut.search(searchKey: "s", filter: nil, from: 0)
        repo.simulateGettingSearchErrorResponse()
        // Then
        XCTAssertTrue(presenter.isFetchAnErrorCalled)
    }
    
  
    
}
