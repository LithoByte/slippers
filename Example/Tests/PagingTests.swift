//
//  PagingTests.swift
//  Slippers_Tests
//
//  Created by Elliot Schrock on 7/7/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import Slippers

class PagingTests: XCTestCase {
    func testPageNotCalledOnInstantiation() {
        var wasCalled = false
        
        let onPage: (Int) -> Void = { _ in wasCalled = true }
        
        let pager = Pager(firstPageValue: 1, onPageUpdate: onPage)
        
        XCTAssert(!wasCalled)
        
        pager.refresh()
    }
    
    func testPageUpdateNotNil() {
        var wasCalled = false
        
        let onPage: (Int) -> Void = { _ in wasCalled = true }
        
        let pager = Pager(firstPageValue: 1, onPageUpdate: onPage)
        
        XCTAssert(!wasCalled)
        XCTAssertNotNil(pager.onPageUpdate)
    }

    func testRefresh() {
        var wasCalled = false
        
        let onPage: (Int) -> Void = { _ in wasCalled = true }
        
        let pager = Pager(firstPageValue: 1, onPageUpdate: onPage)
        
        pager.refresh()
        
        XCTAssertEqual(pager.page, 1)
        XCTAssert(wasCalled)
    }
    
    func testNextPage() {
        var wasCalled = false
        var callCount = 0
        
        let onPage: (Int) -> Void = { _ in
            wasCalled = true
            callCount += 1
        }
        
        let pager = Pager(firstPageValue: 1, onPageUpdate: onPage)
        
        XCTAssertEqual(pager.page, 1)
        pager.refresh()
        XCTAssertEqual(pager.page, 1)
        pager.nextPage()
        XCTAssertEqual(pager.page, 2)
        pager.nextPage()
        XCTAssertEqual(pager.page, 3)
        
        XCTAssert(wasCalled)
        XCTAssertEqual(callCount, 3)
    }

    func testRefreshAfterNextPage() {
        var wasCalled = false
        
        let onPage: (Int) -> Void = { _ in wasCalled = true }
        
        let pager = Pager(firstPageValue: 1, onPageUpdate: onPage)
        
        pager.refresh()
        XCTAssertEqual(pager.page, 1)
        pager.nextPage()
        XCTAssertEqual(pager.page, 2)
        pager.refresh()
        XCTAssertEqual(pager.page, 1)
        XCTAssert(wasCalled)
    }
    
    func testFetchPage() {
        var wasCalled = false
        var callCount = 0
        
        let onPage: (Int) -> Void = { _ in
            wasCalled = true
            callCount += 1
        }
        
        let pager = Pager(firstPageValue: 1, onPageUpdate: onPage)
        
        XCTAssertEqual(pager.page, 1)
        pager.refresh()
        XCTAssertEqual(pager.page, 1)
        pager.nextPage()
        XCTAssertEqual(pager.page, 2)
        pager.fetchPage(7)
        XCTAssertEqual(pager.page, 7)
        
        XCTAssert(wasCalled)
        XCTAssertEqual(callCount, 3)
    }
}
