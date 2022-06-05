//
//  URLSessionFake.swift
//  Test_TeamDocTests
//
//  Created by Guillaume Donzeau on 05/06/2022.
//

import Foundation

class URLSessionFake: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake(completionHandler: completionHandler, data: data, response: response)
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake(completionHandler: completionHandler, data: data, response: response)
        task.completionHandler = completionHandler
        task.data = data
        task.urlResponse = response
        task.responseError = error
        return task
    }
}

class URLSessionDataTaskFake: URLSessionDataTask {
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var data:Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    init(completionHandler: ((Data?, URLResponse?, Error?) -> Void)?, data:Data?, response: URLResponse?) {
        self.completionHandler = completionHandler
        self.data = data
        self.urlResponse = response
    }
    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }
    override func cancel() {}
}
