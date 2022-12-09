//
//  APIService.swift
//  palebedev_1PW2
//
//  Created by Frizer on 08.12.2022.
//

import Foundation
final class APIService{
    static let shared = APIService()
    struct Constants{
        static let headlinesUrl = URL(string: "https://newsapi.org/v2/everything?q=Apple&from=2022-12-08&sortBy=popularity&apiKey=b3e61fe88cb74b59b09c68b9babe278e")
    }
    
    private init(){
        
    }
    
    public func getTopStories(completeon: @escaping (Result<APIResponse,Error>)->Void){
        guard let url = Constants.headlinesUrl
        else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
            data, _, error in
            if let error = error {
                completeon(.failure(error))
            } else if let data = data{
                do{
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completeon(.success(result))
                } catch{
                    completeon(.failure(error))
                }
            }
        }
        task.resume()
    }
}
