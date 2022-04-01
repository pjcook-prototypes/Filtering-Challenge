//
//  FilteringTests.swift
//  FilteringTests
//
//  Created by PJ on 01/04/2022.
//

import XCTest
@testable import Filtering

class FilteringTests: XCTestCase {
    
    func test_case1() throws {
        guard let input = try readInputFile("input.json") else {
            struct InvalidInputFile: Error {}
            throw InvalidInputFile()
        }
        let cards = try parseJson(input)

        measure {
            let userDetails = UserDetails(osVersion: nil, appVersion: nil)
            let filteredCards = filterLayoutResponse(callerDetails: userDetails, cards: cards)
            XCTAssertEqual(["Carousel", "Banner", "New departments list default"], filteredCards.map { $0.name })
        }
    }
    
    func test_case2() throws {
        guard let input = try readInputFile("input.json") else {
            struct InvalidInputFile: Error {}
            throw InvalidInputFile()
        }
        let cards = try parseJson(input)

        measure {
            let userDetails = UserDetails(osVersion: OperatingSystemVersion(value: "15.0.0"), appVersion: nil)
            let filteredCards = filterLayoutResponse(callerDetails: userDetails, cards: cards)
            XCTAssertEqual(["Carousel", "Banner", "Recommendations1", "New departments list 15", "Banner2"], filteredCards.map { $0.name })
        }
    }
    
    func test_case3() throws {
        guard let input = try readInputFile("input.json") else {
            struct InvalidInputFile: Error {}
            throw InvalidInputFile()
        }
        let cards = try parseJson(input)

        measure {
            let userDetails = UserDetails(osVersion: OperatingSystemVersion(value: "14.0.1"), appVersion: nil)
            let filteredCards = filterLayoutResponse(callerDetails: userDetails, cards: cards)
            XCTAssertEqual(["Carousel", "Banner", "New departments list default", "Recommendations2"], filteredCards.map { $0.name })
        }
    }
    
    func test_case4() throws {
        guard let input = try readInputFile("input.json") else {
            struct InvalidInputFile: Error {}
            throw InvalidInputFile()
        }
        let cards = try parseJson(input)

        measure {
            let userDetails = UserDetails(osVersion: OperatingSystemVersion(value: "13.0.0"), appVersion: nil)
            let filteredCards = filterLayoutResponse(callerDetails: userDetails, cards: cards)
            XCTAssertEqual(["Carousel", "Banner", "Old departments list"], filteredCards.map { $0.name })
        }
    }
    
}

extension FilteringTests {
    func readInputFile(_ filename: String) throws -> String? {
        let bundle = Bundle(for: Self.self)
        guard let url = bundle.url(forResource: filename, withExtension: nil) else {
            struct MissingFile: Error {}
            throw MissingFile()
        }
        
        return try String(contentsOf: url)
    }
    
    func parseJson(_ input: String) throws -> [Card] {
        guard let data = input.data(using: .utf8) else {
            struct FailedToConvertJsonToData: Error {}
            throw FailedToConvertJsonToData()
        }
        return try JSONDecoder().decode([Card].self, from: data)
    }
}
