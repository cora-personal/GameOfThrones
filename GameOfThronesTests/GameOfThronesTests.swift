//
//  GameOfThronesTests.swift
//  GameOfThronesTests
//
//  Created by My Apps on 26/01/2021.
//

import XCTest
@testable import GamesOfThrone

class GameOfThronesTests: XCTestCase {
    func testDecoding() {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "Houses", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return
        }
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(Response.self, from: data) else {
            return
        }
        
        XCTAssertEqual(decodedData.name, "House Buckwell of the Antlers")
        XCTAssertEqual(decodedData.region, " The Crownlands")
        XCTAssertEqual(decodedData.coatOfArms, "A rack of golden antlers, on a field of vair(Vair, a stag's attire or)")
        XCTAssertEqual(decodedData.words, "Pride and Purpose")
       
    }
}
