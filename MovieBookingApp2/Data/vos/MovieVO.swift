//
//  MovieVO.swift
//  MovieBookingApp2
//
//  Created by kira on 05/04/2022.
//

import Foundation
import RealmSwift

class MovieVO: Object, Codable {
    
    @Persisted(primaryKey: true)
    var id: Int
    
    @Persisted
    var isNowShowing = false
    
    @Persisted
    var isCommingSoon = false
    
    @Persisted
    var originalTitle: String
    
    @Persisted
    var releaseDate: String
    
    @Persisted
    var genres: List<String>
    
    @Persisted
    var posterPath: String
    
    @Persisted
    var overview: String?
    
    @Persisted
    var rating: Double?
    
    @Persisted
    var runtime: Int?
    
    @Persisted
    var casts: List<CastVO>
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres
        case posterPath = "poster_path"
        case overview
        case rating
        case runtime
//        case casts
    }
    
}
