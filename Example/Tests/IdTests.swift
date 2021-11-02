//
//  IdTests.swift
//  Slippers_Tests
//
//  Created by Elliot Schrock on 11/13/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import Slippers

class IdTests: XCTestCase {
    func testIdentifiable() {
        let post = Post(id: 123)

        XCTAssertEqual(post.id, Post(id: 123).id)
    }
    
    func testComparable() {
        let post = Post(id: 123)

        XCTAssertTrue(post.id < Post(id: 124).id)
    }
    
    func testEquatable() {
        let post = Post(id: 123)

        XCTAssertTrue(post.id == Post(id: 123).id)
    }
}

struct Post: Identifiable {
    let id: Id<Post, Int>
}
