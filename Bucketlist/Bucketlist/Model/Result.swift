//
//  Result.swift
//  Bucketlist
//
//  Created by Júlia on 28/8/22.
//

import Foundation

//JSON data structure sended by Wikipedia's Api

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]  //Dictionnary of pages indexed by the pageid
}

struct Page: Codable, Comparable {
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    var description: String {
        /*
         1. Terms might not exist => use of ?
         2. Description might not be in the terms dictionnary. => use of ?
         3. Description might exist but be an empty array
         */
        terms?["description"]?.first ?? "No further information"
    }
}
