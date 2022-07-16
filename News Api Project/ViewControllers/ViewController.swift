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
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        model.delegate = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        model.getNews()
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        model.getNews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard tableView.indexPathForSelectedRow != nil else{
            return
        }
        
        let selectedArticl = newsArticlas[tableView.indexPathForSelectedRow!.row]
        
        let tranferDestination = segue.destination as! DetaileNewsViewController
        
        tranferDestination.articles = selectedArticl
        
        
    }
    
    func fetchArticlas(_ articls: [ArticlesDM]) {
        self.newsArticlas = articls
        
        DispatchQueue.main.async { //calling it in the main thread coz its a UI changing thing
            self.tableView.reloadData()
            print("DelegateCall")
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

