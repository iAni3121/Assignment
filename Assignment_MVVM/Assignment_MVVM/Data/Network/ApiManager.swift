//
//  ApiManager.swift
//  Assignment_MVVM
//
//  Created by Anirudha Kumar on 14/06/22.
//

import Foundation
import Combine

final class APIManager {
    
    static let sharedInstance = APIManager()
    
    private init() {}
    
    func getDataFromServer(urlString: String, methodType: String = "GET", httpBody: Data? = nil, completion: @escaping (Data?, Error?)-> Void) {
        
        guard let url = URL(string: urlString) else { return }
        let urlSession = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = methodType
        request.httpBody = httpBody
        urlSession.dataTask(with: request) { (data, response, error) in
            if let jsonData = data {
                completion(jsonData, nil)
            } else {
                completion(nil, error)
            }
        }.resume()
        
    }
    
//    func decode<T: Decodable>(_ data: Data)-> AnyPublisher<T, Error> {
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .secondsSince1970
//        return Just(data)
//            .decode(type: T.self, decoder: decoder)
//            .mapError { error in
//            .parsing(description: error.localizedDescription)
//            }
//            .eraseToAnyPublisher()
//    }
}
