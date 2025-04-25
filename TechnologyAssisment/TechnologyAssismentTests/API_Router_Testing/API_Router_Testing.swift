// Untitled.swift
// TechnologyAssisment
// Created by Mashhood Qadeer on 25/04/2025

import XCTest
@testable import TechnologyAssisment

final class API_Router_Testing: XCTestCase{

    func testAPIRouting() throws {
         
         //Testing API URL
         let apiURL = API_ROUTES.MOST_VIEWED(sectionInformation: "all-sections", duration: 7)
         dump(apiURL.url)
         XCTAssertNotNil(apiURL.url, "It's found to be nil")
         
    }

}
