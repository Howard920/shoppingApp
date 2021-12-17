//
//  NetWorkHandler.swift
//  shoppingApp
//
//  Created by Jason Deng on 2021/12/1.
//

import Foundation
import UIKit
struct NetWorkHandler: Codable {
    static let host = "http://127.0.0.1"

    
    static func parseJson<T:Codable>(_ data: Data) -> [T]? {
        let decode = JSONDecoder()
        do {
            return try decode.decode([T].self, from: data)
        } catch  {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func parseJson<T:Codable>(getOne data: Data) -> T? {
        let decode = JSONDecoder()
        do {
            return try decode.decode(T.self, from: data)
        } catch  {
            print(error.localizedDescription)
            return nil
        }
    }

}

struct ImageLoader {
    typealias Handler = (Result<UIImage, ImageLoadingError>) -> Void

    var session = URLSession.shared

    func loadImage(at url: URL,
                   then handler: @escaping Handler) {
        let task = session.dataTask(with: url) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    handler(.success(image))
                } else {
                    handler(.failure(.invalidData))
                }
            case .failure(let error):
                handler(.failure(.networkFailure(error)))
            }
        }

        task.resume()
    }
}

enum ImageLoadingError: Error {
    case networkFailure(Error)
    case invalidData
}

extension URLSession {
    func dataTask(
        with url: URL,
        handler: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionDataTask {
        dataTask(with: url) { data, _, error in
            if let error = error {
                handler(.failure(error))
            } else {
                handler(.success(data ?? Data()))
            }
        }
    }
}
