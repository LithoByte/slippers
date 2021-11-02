//
//  StringIdTests.swift
//  Slippers_Tests
//
//  Created by Calvin Collins on 11/2/21.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
@testable import Slippers

class StringIdTests: XCTestCase {
    func testIdentifiable() {
        let post = Post(id: "123")

        XCTAssertEqual(post.id, Post(id: "123").id)
    }
    
    func testComparable() {
        let post = Post(id: "a")

        XCTAssertTrue(post.id < Post(id: "a").id)
    }
    
    func testEquatable() {
        let post = Post(id: "123")

        XCTAssertTrue(post.id == Post(id: "123").id)
    }
}

private struct Post: Identifiable {
    let id: StringId<Post>
}
