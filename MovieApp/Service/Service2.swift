//
//  Service2.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 7.08.2023.
//

import Foundation


class Service2 {
    
    func movie(completed: @escaping ([Movie]) -> Void) {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYTZlYWM5ODIxYzMyNzEyMDc4MTg0ODczM2Q2OTkwNSIsInN1YiI6IjY0YmU2MDVkNThlZmQzMDBhY2UyYTY1MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JVKCjOR-ZqvLqGI0_IiPykmlO06Z4QpL5onDH_f_oeQ"
        ]
        
        let request2 = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/genre/movie/list?language=en")! as URL,
                                           cachePolicy: .useProtocolCachePolicy,
                                           timeoutInterval: 10.0)
        request2.httpMethod = "GET"
        request2.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request2 as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse as Any)
            }
        })
        
        dataTask.resume()
    }
}
