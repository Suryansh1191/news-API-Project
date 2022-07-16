//
//  DetaileNewsViewController.swift
//  News Api Project
//
//  Created by suryansh Bisen on 16/07/22.
//

import UIKit

class DetaileNewsViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentText: UITextView!
    
    var articles: ArticlesDM?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //doing this because on cell re use we where getting the old articls information

        
        titleLabel.text = articles?.title
        contentText.text = articles?.content
        
        let image = CacheManager.getVideoCache((articles?.imageUrl)!)
        imageView.image = UIImage(data: image!)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
