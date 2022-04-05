//
//  RealmDb.swift
//  MovieBookingApp2
//
//  Created by kira on 05/04/2022.
//

import Foundation
import RealmSwift

class RealmDB {
    static let shared = RealmDB()
    let realm = try! Realm()
    
    private init() {
        print("=======================")
        print("Realm file is at: \(realm.configuration.fileURL!.absoluteString)")
    }
}
