//
//  JsonTests.swift
//  Slippers_Tests
//
//  Created by Elliot Schrock on 7/7/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import Slippers

class JsonTests: XCTestCase {

    func testSnakeCaseEncode() throws {
        let neo = Human(firstName: "Neo", birthDate: Date())
        let data = JsonProvider.encode(neo)
        XCTAssertNotNil(data)
        guard let d = data else { return }
        let json = String(data: d, encoding: .utf8)
        XCTAssertNotNil(json)
        
        if let json = json {
            XCTAssert(json.contains("first_name"))
            XCTAssert(!json.contains("firstName"))
        }
    }

    func testIsoEncode() throws {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let birthDateString = "1985-01-25T00:00:00Z"
        guard let birthDate = formatter.date(from: birthDateString) else { return }
        let neo = Human(firstName: "Neo", birthDate: birthDate)
        let data = JsonProvider.encode(neo)
        XCTAssertNotNil(data)
        
        guard let d = data else { return }
        let json = String(data: d, encoding: .utf8)
        XCTAssertNotNil(json)
        
        if let json = json {
            XCTAssert(json.contains(birthDateString))
        }
    }

    func testSnakeCaseDecode() throws {
        let birthDateString = "1985-01-25T00:00:00Z"
        let json = "{\"first_name\":\"Neo\",\"birth_date\":\"\(birthDateString)\"}"
        let neo = JsonProvider.decode(Human.self, from: json.data(using: .utf8)!)
        XCTAssertNotNil(neo)
        XCTAssertEqual(neo?.firstName, "Neo")
    }

    func testIsoDecode() throws {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let birthDateString = "1985-01-25T00:00:00Z"
        let json = "{\"first_name\":\"Neo\",\"birth_date\":\"\(birthDateString)\"}"
        let neo = JsonProvider.decode(Human.self, from: json.data(using: .utf8)!)
        XCTAssertNotNil(neo)
        XCTAssertEqual(neo?.firstName, "Neo")
        if let birthDate = formatter.date(from: birthDateString) {
            XCTAssertEqual(neo?.birthDate, birthDate)
        }
    }
    
//    func testForceDecodeMissingError() {
//        let birthDateString = "1985-01-025T00:00:00Z"
//        let json = "{\"birth_date\":\"\(birthDateString)\"}"
//
//        XCTAssertThrowsError(JsonProvider.forceDecode(Human.self, from: json.data(using: .utf8)!))
//    }
//
//    func testForceDecodeWrongError() {
//        let json = "{\"first_name\":\"Neo\",\"birth_date\":\"Neo\"}"
//
//        XCTAssertThrowsError(JsonProvider.forceDecode(Human.self, from: json.data(using: .utf8)!))
//    }
}

struct Human: Codable {
    var firstName: String
    var birthDate: Date
}
