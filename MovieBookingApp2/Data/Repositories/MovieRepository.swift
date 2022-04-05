//
//  MovieRepository.swift
//  MovieBookingApp2
//
//  Created by kira on 05/04/2022.
//

import Foundation

protocol MovieRepository {
    
    func saveNowShowingMovies(data: [MovieVO])
    func getNowShowingMovies(completion: @escaping ([MovieVO]) -> Void)
    func saveCommingSoonMovies(data: [MovieVO])
    func getCommingSoonMovies(completion: @escaping ([MovieVO]) -> Void)
    
}

class MovieRepositoryImpl: BaseRepository, MovieRepository {
    
    static let shared = MovieRepositoryImpl()
    
    private override init() {
    }
    
    func saveNowShowingMovies(data: [MovieVO]) {
        do {
            try self.realm.write({
                let objects = data.map { movie -> MovieVO in
                    if let savedObject = self.realm.object(ofType: MovieVO.self, forPrimaryKey: movie.id) {
                        savedObject.isNowShowing = true
                        return savedObject
                    } else {
                        movie.isNowShowing = true
                        return movie
                    }
                }
                self.realm.add(objects, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getNowShowingMovies(completion: @escaping ([MovieVO]) -> Void) {
        let data: [MovieVO] = self.realm.objects(MovieVO.self)
            .filter { $0.isNowShowing }
        completion(data)
    }
    
    func saveCommingSoonMovies(data: [MovieVO]) {
        do {
            try self.realm.write({
                let objects = data.map { movie -> MovieVO in
                    if let savedObject = self.realm.object(ofType: MovieVO.self, forPrimaryKey: movie.id) {
                        savedObject.isCommingSoon = true
                        return savedObject
                    } else {
                        movie.isCommingSoon = true
                        return movie
                    }
                }
                self.realm.add(objects, update: .modified)
            })
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func getCommingSoonMovies(completion: @escaping ([MovieVO]) -> Void) {
        let data: [MovieVO] = self.realm.objects(MovieVO.self)
            .filter { $0.isCommingSoon }
        completion(data)
    }
    
}
