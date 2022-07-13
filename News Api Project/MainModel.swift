//
//  MainModel.swift
//  News Api Project
//
//  Created by suryansh Bisen on 13/07/22.
//

import Foundation

class MainModel{
    
    func getNews(){
        
        let url = URL(string: ConstantsData.API_URL)
        
        guard url != nil else{
            print("empty url")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error != nil || data == nil {
                print("API ERROR")
                return
            }
            
            print(data)
            
        }
        
        dataTask.resume()
        
    }
}
