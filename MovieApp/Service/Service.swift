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
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        let request = NSMutableURLRequest(url: NSURL(string:
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
    
//    func fetchMovieTrailers(for movieId: Int, completed: @escaping ([Video]) -> Void) {
//        let url = "https://www.googleapis.com/youtube/v3/search?key=\(YoutubeAPI_KEY)&part=snippet&q=Movie \(Video) Official Trailer&type=video"
//        if let videoURL = URL(string: url) {
//            let session = URLSession.shared
//
//            let dataTask = session.dataTask(with: videoURL) { (data, response, error) in
//                if let error = error {
//                    print("Error fetching video data: \(error)")
//                } else if let data = data {
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                        if let items = json?["items"] as? [[String: Any]] {
//                            var videoList: [Video] = []
//
//                            for item in items {
//                                if let videoId = item["id"] as? [String: Any], let videoIdString = videoId["videoId"] as? String,
//                                   let snippet = item["snippet"] as? [String: Any], let title = snippet["title"] as? String,
//                                   let thumbnail = snippet["thumbnails"] as? [String: Any],
//                                   let thumbnailInfo = thumbnail["default"] as? [String: Any], let thumbnailURL = thumbnailInfo["url"] as? String {
//                                    let video = Video(id: videoIdString, title: title, thumbnailURL: thumbnailURL)
//                                    videoList.append(video)
//                                }
//                            }
//
//                            completed(videoList)
//                        }
//                    } catch {
//                        print("JSON parsing error: \(error)")
//                    }
//                }
//            }
//
//            dataTask.resume()
//        }
//    }
}
