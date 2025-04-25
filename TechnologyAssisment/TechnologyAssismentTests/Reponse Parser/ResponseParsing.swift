////  Untitled.swift
////  TechnologyAssisment
////  Created by Mashhood Qadeer on 25/04/2025.

import XCTest
@testable import TechnologyAssisment

final class ResponseParsingTestCases: XCTestCase {

    func testFileReading() throws {
         
         let expectations = expectation(description: "Waiting for to get the file content")
         let testBundle = Bundle(for: type(of: self))
    
         FileIO.shared.readFile(
            fileName: "MostViewed",
            bundle: testBundle) { response in
             XCTAssertNotNil(response)
             dump(response)
             expectations.fulfill()
          } onFailure: { error in
              XCTAssertNil(error, "Eror of type \(error)")
         }

         self.wait(for: [expectations], timeout: 30)
        
    }

    func testAPIResponseParsing() throws {
         
         let expectations = expectation(description: "Waiting for to get the file content")
         let testBundle = Bundle(for: type(of: self))
    
         FileIO.shared.readFile(
            fileName: "MostViewed",
            bundle: testBundle) { response in
             
                response.decodeJSON(to: NYTResponse.self) { response in
                    dump(response)
                    XCTAssertNotNil(response)
                    expectations.fulfill()
                } onFailure: { error in
                    XCTAssertNil(error, "Eror of type \(error)")
                }
                
          } onFailure: { error in
              XCTAssertNil(error, "Eror of type \(error)")
         }

         self.wait(for: [expectations], timeout: 30)
        
    }
    
    func testAPIResponseParsingForMissingData() throws {
         
         let expectations = expectation(description: "Waiting for to get the file content")
         let testBundle = Bundle(for: type(of: self))
    
         FileIO.shared.readFile(
            fileName: "MostViewed-Missing-Keys",
            bundle: testBundle) { response in
             
                response.decodeJSON(to: NYTResponse.self) { response in
                    dump(response)
                    XCTAssertNotNil(response)
                    expectations.fulfill()
                } onFailure: { error in
                    XCTAssertNil(error, "Eror of type \(error)")
                }
                
          } onFailure: { error in
              XCTAssertNil(error, "Eror of type \(error)")
         }

         self.wait(for: [expectations], timeout: 30)
        
    }
    
}
