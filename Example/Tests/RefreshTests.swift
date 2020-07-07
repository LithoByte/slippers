//
//  RefreshTests.swift
//  Slippers_Tests
//
//  Created by Elliot Schrock on 7/7/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import Slippers

class RefreshTests: XCTestCase {

    func testNoRefreshOnInstantiation() throws {
        var wasCalled = false
        
        let onRefresh: () -> Void = { wasCalled = true }
        
        let refresher = Refresher(onRefresh)
        
        XCTAssert(!wasCalled)
        
        refresher.refresh()
    }

    func testRefresh() throws {
        var wasCalled = false
        
        let onRefresh: () -> Void = { wasCalled = true }
        
        let refresher = Refresher(onRefresh)
        
        refresher.refresh()
        
        XCTAssert(wasCalled)
    }

    func testMetaRefresh() throws {
        var wasCalled = false
        
        let onRefresh: () -> Void = { wasCalled = true }
        
        let refresher = Refresher(onRefresh)
        let meta = MetaRefresher(refresher)
        
        XCTAssert(!wasCalled)
        
        meta.refresh()
        
        XCTAssert(wasCalled)
    }
}
