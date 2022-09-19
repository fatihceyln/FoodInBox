//
//  NetworkingManager.swift
//  FoodInBox
//
//  Created by Fatih Kilit on 19.09.2022.
//

import Foundation

class NetworkingManager {
    static let shared = NetworkingManager()
    private init() {}
    
    private let queue = DispatchQueue(label: "com.fatih.NetworkingManager", qos: .background)
    
    func download(url: URL, completion: @escaping (Result<Data, FCError>) -> ()) {
        queue.async {
            
            var request = URLRequest(url: url)
            request.addValue("xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=", forHTTPHeaderField: "Api-Key")
            request.addValue("AtS1aPFxlIdVLth6ee2SEETlRxk=", forHTTPHeaderField: "Alias-Key")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let _ = error {
                    completion(.failure(.unableToComplete))
                    return
                }
                
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                completion(.success(data))
            }
            .resume()
        }
    }
}
