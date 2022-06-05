//
//  Model_TeamDocTests.swift
//  Test_TeamDocTests
//
//  Created by Guillaume Donzeau on 05/06/2022.
//

import XCTest
@testable import Test_TeamDoc

class Model_TeamDocTests: XCTestCase {

    func testGetTwoGeneralBasesDifferentWhenCompareThemThenNotEquatable() {
        let firstGeneralBase:GeneralBase = Bundle.main.decode("ShortDataFile.json")
        var secondGeneralBase:GeneralBase = Bundle.main.decode("ShortDataFile.json")
        
        XCTAssertTrue(firstGeneralBase == secondGeneralBase)
        
        secondGeneralBase.proStatus.remove(at: 0)
        
        XCTAssertFalse(firstGeneralBase == secondGeneralBase)
        
        
    }

}
