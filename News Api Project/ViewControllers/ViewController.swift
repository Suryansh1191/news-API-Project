//
//  ViewController.swift
//  News Api Project
//
//  Created by suryansh Bisen on 13/07/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MainModelDelegate {
    

    var model = MainModel()
    var newsArticlas = [ArticlesDM]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        model.delegate = self
        
        model.getNews()
    }
    
    func fetchArticlas(_ articls: [ArticlesDM]) {
        self.newsArticlas = articls
        
        DispatchQueue.main.async { //calling it in the main thread coz its a UI changing thing
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConstantsData.NEWS_TABLECELL_ID, for: indexPath) as! ArticlesTableViewCell
        
        let currentArticles = self.newsArticlas[indexPath.row]
        cell.setCell(currentArticles)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticlas.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

