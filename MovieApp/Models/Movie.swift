//
//  Movie.swift
//  MovieApp
//
//  Created by Nilay KADİROĞULLARI on 25.07.2023.
//

import Foundation

struct MovieResponse: Codable {
    var page: Int?
    var results: [Movie]?
    var total_pages: Int?
    var total_results: Int?
}

struct Movie: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var id: Int?
    let title: String?
    var original_language: String?
    var original_title: String?
    let overview: String?
    let poster_path: String?
    var media_type: String?
    var genre_ids: [Int]?
    var popularity: Double?
    let release_date: String?
    var video: Bool?
    let vote_average: Double?
    var vote_count: Int?
}
