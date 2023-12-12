//
//  APIManager.swift
//  MetaSecret
//
//  Created by Dmitry Kuklin on 02.01.2023.
//

import Combine
import Foundation
import OSLog

protocol APIManagerProtocol {
    func fetchData<T>(_ endpoint: any HTTPRequest) -> Future<T, Error> where T: Decodable
}

class APIManager: NSObject, APIManagerProtocol {
    static let develop = "http://api.meta-secret.org/"

    private(set) var jsonManager: JsonSerealizable
    private(set) var userService: UsersServiceProtocol
    private(set) var rustManager: RustProtocol

    init(jsonManager: JsonSerealizable, userService: UsersServiceProtocol, rustManager: RustProtocol) {
        self.userService = userService
        self.jsonManager = jsonManager
        self.rustManager = rustManager
    }

    func fetchData<T>(_ endpoint: any HTTPRequest) -> Future<T, Error> where T: Decodable {
        return Future { promise in
            guard let url = URL(string: APIManager.develop + endpoint.path) else {
                Logger().error("Error: \(MetaSecretErrorType.networkError)")
                promise(.failure(MetaSecretErrorType.networkError))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method.rawValue
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            if let jsonData = endpoint.params.data(using: .utf8) {
                if let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                    request.httpBody = jsonData
                } else {
                    Logger().error("Error: \(MetaSecretErrorType.networkError)")
                    promise(.failure(MetaSecretErrorType.networkError))
                    return
                }
            } else {
                Logger().error("Error: Invalid data for JSON.")
                promise(.failure(MetaSecretErrorType.networkError))
                return
            }

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    Logger().error("Error: \(error.localizedDescription)")
                    promise(.failure(error))
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let object = try decoder.decode(T.self, from: data)
                        Logger().info("Object parsed")
                        promise(.success(object))
                    } catch {
                        promise(.failure(error))
                    }
                } else {
                    Logger().error("Error: \(MetaSecretErrorType.networkError)")
                    promise(.failure(NSError(domain: "NetworkLayer", code: 0, userInfo: nil)))
                }
            }
            task.resume()
        }
    }
}
