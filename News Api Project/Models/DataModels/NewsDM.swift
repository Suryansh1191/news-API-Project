//
//  NewsDM.swift
//  News Api Project
//
//  Created by suryansh Bisen on 13/07/22.
//

import Foundation

struct NewsDM: Decodable {
    
    var articles: [ArticlesDM]?
    var totalResults: Int
    
    
    enum CodingKeys: String, CodingKey{
        case articles
        case totalResults
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.articles = try container.decode([ArticlesDM].self, forKey: .articles)
        self.totalResults = try container.decode(Int.self, forKey: .totalResults)
    }
    
}
