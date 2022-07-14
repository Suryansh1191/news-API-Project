//
//  NewsDM.swift
//  News Api Project
//
//  Created by suryansh Bisen on 13/07/22.
//

import Foundation

struct ArticlesDM: Decodable {
    
    var title: String?
    var description: String?
    var author: String?
    var content: String?
    var url: String?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case content
        case author
        case url
        case imageUrl = "urlToImage"
    }
    
    init (from decoder: Decoder) throws {
        
        let conatiner = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try conatiner.decode(String?.self, forKey: .title)
        self.description = try conatiner.decode(String?.self, forKey: .description)
        self.author = try conatiner.decode(String?.self, forKey: .author)
        self.content = try conatiner.decode(String?.self, forKey: .content)
        self.url = try conatiner.decode(String?.self, forKey: .url)
        self.imageUrl = try conatiner.decode(String?.self, forKey: .imageUrl)
    }
    
}
