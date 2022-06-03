//
//  APISearch.swift
//  Test_TeamDoc
//
//  Created by Guillaume Donzeau on 02/06/2022.
//

import Foundation

class DataService {
    static var shared = DataService()
    private init() {}
    private var session = URLSession(configuration: .default)
    
    init(session:URLSession) {
        self.session = session
    }
    
    private var task:URLSessionDataTask?
    
    func getData(stringAdress: String, completion: @escaping (Result<GeneralBase,APIErrors>)->Void) {
        
        guard let url = URL(string: stringAdress) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url:url)
        request.httpMethod = APIConfig.httpMethod
        
        task?.cancel()
        task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil  else {
                    completion(.failure(.errorGenerated))
                    return
                }
                guard let dataUnwrapped = data else {
                    completion(.failure(.noData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(.invalidStatusCode))
                    return
                }
                do {
                    let data = try JSONDecoder().decode(GeneralBase.self, from: dataUnwrapped)
                    print()
                    completion(.success(data))
                    
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }
        task?.resume()
    }
}
