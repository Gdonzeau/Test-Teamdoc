//
//  Test_TeamDocTests.swift
//  Test_TeamDocTests
//
//  Created by Guillaume Donzeau on 02/06/2022.
//

import XCTest
@testable import Test_TeamDoc

class Test_TeamDocTests: XCTestCase {

    func testGetConversionShouldPostFailedCallbackIfIncorrectUrl() {
        let errorExpected:APIErrors = .invalidURL
        var errorReceived:APIErrors = .noError
        let urlAdress = "Truc muche"
        XCTAssertNotEqual(errorExpected, errorReceived)
        // No URL to configure...
        let service = DataService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        service.getData(stringAdress: urlAdress) { result in
            
            switch result {
            
            case.success( _):
                XCTFail("Should not have succeeded")
                
            case.failure(let error):
                //Then
                XCTAssertEqual(errorExpected, error)
                errorReceived = error
            }
            XCTAssertEqual(errorExpected, errorReceived)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.00)
    }
    
    func testGetConversionShouldPostFailedCallbackIfError() {
        let errorExpected:APIErrors = .errorGenerated
        var errorReceived:APIErrors = .noError
        let urlAdress = "http://www.bonneAdresseUrl.com"
        XCTAssertNotEqual(errorExpected, errorReceived)
        let service = DataService(
            session: URLSessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, error: FakeResponse.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        service.getData(stringAdress: urlAdress) { result in
            
            switch result {
            
            case.success( _):
                XCTFail("Should not have succeeded")
                
            case.failure(let error):
                // Then
                XCTAssertEqual(errorExpected, error)
                errorReceived = error
            }
            XCTAssertEqual(errorExpected, errorReceived)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConversionShouldPostFailedCallbackIfNoData() {
        let errorExpected:APIErrors = .noData
        var errorReceived:APIErrors = .noError
        let urlAdress = "http://www.bonneAdresseUrl.com"
        XCTAssertNotEqual(errorExpected, errorReceived)
        let service = DataService(
            session: URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        service.getData(stringAdress: urlAdress) { result in
            
            switch result {
            
            case.success( _):
                XCTFail("Should not have succeeded")
                
            case.failure(let error):
                //Then
                XCTAssertEqual(errorExpected, error)
                errorReceived = error
            }
            XCTAssertEqual(errorExpected, errorReceived)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConversionShouldPostFailedCallbackIfIncorrectResponse() {
        let errorExpected:APIErrors = .invalidStatusCode
        var errorReceived:APIErrors = .noError
        let urlAdress = "http://www.bonneAdresseUrl.com"
        XCTAssertNotEqual(errorExpected, errorReceived)
        let service = DataService(
            session: URLSessionFake(data: FakeResponse.correctData, response: FakeResponse.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        service.getData(stringAdress: urlAdress) { result in
            
            switch result {
            
            case.success( _):
                XCTFail("Should not have succeeded")
                
            case.failure(let error):
                //Then
                XCTAssertEqual(errorExpected, error)
                errorReceived = error
            }
            XCTAssertEqual(errorExpected, errorReceived)
           
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConversionShouldPostFailedCallbackIfIncorrectData() {
        let errorExpected:APIErrors = .decodingError
        var errorReceived:APIErrors = .noError
        let urlAdress = "http://www.bonneAdresseUrl.com"
        XCTAssertNotEqual(errorExpected, errorReceived)
        let service = DataService(
            session: URLSessionFake(data: FakeResponse.incorrectData, response: FakeResponse.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        service.getData(stringAdress: urlAdress) { result in
            
            switch result {
            
            case.success( _):
                XCTFail("Should not have succeeded")
                
            case.failure(let error):
                //Then
                XCTAssertEqual(errorExpected, error)
                errorReceived = error
            }
            XCTAssertEqual(errorExpected, errorReceived)
           
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetConversionShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        //Given
        let dataAwaited = "MEDICAL"
        var dataToCheck = ""
        let urlAdress = "http://www.bonneAdresseUrl.com"
        XCTAssertNotEqual(dataAwaited, dataToCheck)
        let service = DataService(
            session: URLSessionFake(data: FakeResponse.correctData, response: FakeResponse.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        service.getData(stringAdress: urlAdress) { result in
            
            switch result {
            
            case.success(let data):
                let dataGot = data.proStatus[0].label
                XCTAssertEqual(dataAwaited, dataGot)
                dataToCheck = dataGot
                
            case.failure(let error):
            XCTFail("Should not have failed with :\(error)")
            }
            //Then
            XCTAssertEqual(dataAwaited, dataToCheck)
           
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
