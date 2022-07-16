//
//  ArticlesTableViewCell.swift
//  News Api Project
//
//  Created by suryansh Bisen on 14/07/22.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var content: UILabel!
    
    var article: ArticlesDM?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ a:ArticlesDM){
        self.article = a
        
        self.title.text = article?.title
        self.content.text = article?.description
        
        //image set
        guard self.article?.imageUrl != nil else{
            return
        }
        
        //working on cache image
        if let cachedImage = CacheManager.getVideoCache(self.article!.imageUrl!) {
            self.ImageView.image = UIImage(data: cachedImage)
            return
        }
        
        let url = URL(string: self.article!.imageUrl!)
        
        let sesion = URLSession.shared
        
        //downloading image here to set in UI IMAGE
        let dataTask = sesion.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                //saving in cache
                CacheManager.setImageCache(url!.absoluteString, data)
                
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.ImageView.image = image
                }
                
            }
            
        }
        dataTask.resume()
    }

}
