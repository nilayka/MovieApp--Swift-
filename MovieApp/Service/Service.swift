//
//  Service.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 25.07.2023.
//

import Foundation

class Service {
    //Singleton
    static let shared = Service()
    
    //bak
    func fetchMovieList(completed: @escaping ([Movie]) -> Void) {
        //
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        //! kaldır
        let request = NSMutableURLRequest(url: NSURL(string:
                                                        //strın olmamalı ıcerde
                "https://api.themoviedb.org/3/trending/movie/week")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        //httpMethod nasıl alınabılır
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                do {
                    let dict =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]
                    print("\(String(data: try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted), encoding: .utf8)!)")
                    
                    let decodeObject = try JSONDecoder().decode(MovieResponse.self,from:data!)
                    
                    if !(decodeObject.results?.isEmpty ?? true) {
                        completed(decodeObject.results ?? [])
                    }
                } catch let myJSONError {
                    print(myJSONError)
                }
            }
        })
        
        dataTask.resume()
    }
}
