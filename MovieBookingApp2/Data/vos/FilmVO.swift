//
//  FilmVO.swift
//  MovieBookingApp2
//
//  Created by kira on 14/04/2022.
//

import Foundation
import RealmSwift

class FilmVO: Codable {
    
    let id: Int
    
    let originalTitle: String
    
    let releaseDate: String
    
    var genres: [String]
    
    let posterPath: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case genres
        case posterPath = "poster_path"
    }
    
    func toMovieVO() -> MovieVO {
        let vo = MovieVO()
        vo.id = id
        vo.originalTitle = originalTitle
        vo.releaseDate = releaseDate
        vo.posterPath = posterPath
        
        let genresList = List<String>()
        genresList.append(objectsIn: genres)
        vo.genres = genresList
        
        return vo
    }
}
