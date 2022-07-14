//
//  MainModel.swift
//  News Api Project
//
//  Created by suryansh Bisen on 13/07/22.
//

import Foundation

protocol MainModelDelegate{
    func fetchArticlas (_ articls: [ArticlesDM])
}

class MainModel{
    
    var delegate: MainModelDelegate?
    
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
            
            do{
                let deocder = JSONDecoder()
                let decodableResponce = try deocder.decode(NewsDM.self, from: data!)
                
                if decodableResponce.articles != nil {
                    self.delegate?.fetchArticlas(decodableResponce.articles!)
                }
                
                print(decodableResponce)
            }catch{
                print(error)
            }
            
            
        }
        
        dataTask.resume()
        
    }
}
