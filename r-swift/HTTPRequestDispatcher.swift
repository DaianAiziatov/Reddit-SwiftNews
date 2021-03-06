//
//  HTTPRequestDispatcher.swift
//  r-swift
//
//  Created by Daian Aziatov on 2020-06-08.
//  Copyright © 2020 Daian Aziatov. All rights reserved.
//

import Foundation

struct HTTPRequestDispatcher: RequestDispatching {
    private let session: URLSession

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func dispatch<T: APIRouting>(_ router: T,
                                 configuration: NetworkConfiguration,
                                 completion: @escaping RequestDispatcherCompletion) {
        guard let request = try? urlRequest(from: router,
                                            with: configuration) else {
            completion(nil, HTTPRequestDispatcherError.invalidURL, nil)
            return
        }
        session.dataTask(with: request, completionHandler: { data, response, error in
            completion(data, error, response as? HTTPURLResponse)
        }).resume()
    }

    private func urlRequest<T: APIRouting>(from router: T, with configuration: NetworkConfiguration) throws -> URLRequest {
        guard let baseURL = URL(string: configuration.basePath) else {
            throw HTTPRequestDispatcherError.invalidURL
        }
        var urlComponents = URLComponents(string: baseURL.appendingPathComponent(router.path).absoluteString)

        if let queryItemProvider = router as? QueryItemProviding {
            urlComponents?.queryItems = queryItemProvider.queryItems
        }

        guard let url = urlComponents?.url else {
            throw HTTPRequestDispatcherError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        urlRequest.timeoutInterval = configuration.timeoutInterval

        return urlRequest
    }
}
