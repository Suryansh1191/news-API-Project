//
//  MainModel.swift
//  News Api Project
//
//  Created by suryansh Bisen on 13/07/22.
//

import Foundation

protocol MainModelDelegate{
    func fetchArticlas (_ articls: [ArticlesDM], isSearchResult: Bool)
}

class MainModel{
    
    var totalPage: Int = 0
    var currentPage = 1
    var delegate: MainModelDelegate?
    
    func getNews(_ searchResult: String?, _ pageNumber: Int){
        
        print("Api call")

        var url: URL?
        
        currentPage = currentPage + 1
        
        if searchResult == nil {
            url = URL(string: "\(ConstantsData.API_URL_TOP_HEADLINES)?country=\(ConstantsData.COUNTRY)&pageSize=10&page=\(currentPage)&apiKey=\(ConstantsData.API_KEY)")
        }else{
            url = URL(string: "\(ConstantsData.API_URL_EVERYTHING)?q=\(searchResult!)&pageSize=10&page=\(currentPage)&apiKey=\(ConstantsData.API_KEY)")
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error != nil || data == nil {
                print("API ERROR")
                return
            }
            
            print(data?.description as Any)
            
            do{
                let deocder = JSONDecoder()
                let decodableResponce = try deocder.decode(NewsDM.self, from: data!)
                
                var totalPage: Int!
                if decodableResponce.totalResults%10 != 0 {
                    totalPage = decodableResponce.totalResults/10 + 1
                }else{
                    totalPage = decodableResponce.totalResults/10
                }
                
                self.totalPage = totalPage
                
                if decodableResponce.articles != nil {
                    if searchResult != nil {
                        self.delegate?.fetchArticlas(decodableResponce.articles!, isSearchResult: true)
                    }else{
                        self.delegate?.fetchArticlas(decodableResponce.articles!, isSearchResult: false)
                    }
                    
                }
                
                print(decodableResponce)
            }catch{
                print(error)
            }
            
            
        }
        
        dataTask.resume()
        
    }
}
