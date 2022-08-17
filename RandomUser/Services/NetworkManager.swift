//
//  NetworkManager.swift
//  RandomUser
//
//  Created by igor s on 17.08.2022.
//

import Foundation
import Alamofire

let randomUserLink = "https://randomuser.me/api/"

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchUser(from url: String, completion: @escaping(Result<User, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let user = User.getUser(value: value)
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
