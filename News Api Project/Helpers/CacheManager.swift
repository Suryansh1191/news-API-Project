//
//  CacheManager.swift
//  News Api Project
//
//  Created by suryansh Bisen on 14/07/22.
//

import Foundation

class CacheManager {
    
    static var cache = [String: Data]()
    
    static func setImageCache(_ url:String, _ data: Data?){
         cache[url] = data
    }
    
    static func getVideoCache(_ url: String) -> Data? {
        return cache[url]
    }
    
}
