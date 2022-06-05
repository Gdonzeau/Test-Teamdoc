//
//  FakeResponse.swift
//  Test_TeamDocTests
//
//  Created by Guillaume Donzeau on 05/06/2022.
//

import Foundation

class FakeResponse {
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponse.self)
        let url = bundle.url(forResource: "ShortDataFile", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let incorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Response
    
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://adresseInternet.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://adresseInternet.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!


    
    // MARK: - Error
    
    class QuoteError: Error {}
    static let error = QuoteError()
}
