//// NetworkingTesting.swift
//// TechnologyAssisment
//// Created by Mashhood Qadeer on 25/04/2025.

import XCTest
import Combine
@testable import TechnologyAssisment

final class NetworkingTesting: XCTestCase{

    var disposebag: Set<AnyCancellable> = Set<AnyCancellable>()
    
    func testNetWorking() throws {
         
         let expectations = expectation(description: "Waiting for to get the file content")
         let apiRoute = API_ROUTES.MOST_VIEWED(sectionInformation: "all-sections", duration: 7)
      
         HttpService.shared.request(with: apiRoute, to: NYTResponse.self)
            .sink { status in
                
                dump(status)
                
            } receiveValue: { nYTResponse in
                
                dump(nYTResponse)
                expectations.fulfill()
                XCTAssertNotNil(nYTResponse)
                
            }.store(in: &disposebag)

          self.wait(for: [expectations], timeout: 30)
         
    }

}
