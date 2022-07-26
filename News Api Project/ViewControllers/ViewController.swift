//
//  ViewController.swift
//  News Api Project
//
//  Created by suryansh Bisen on 13/07/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MainModelDelegate {
    
    

    var model = MainModel()
    var newsArticlas = [ArticlesDM]()
    let refreshControl = UIRefreshControl()
    var cacheArticlsData = [ArticlesDM]()
    
    private let searchVC = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "NewsForYou"
        
        tableView.dataSource = self
        tableView.delegate = self
        model.delegate = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        createSearchBar()
        model.getNews(nil, 1)
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        model.getNews(nil, 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard tableView.indexPathForSelectedRow != nil else{
            return
        }
        
        let selectedArticl = newsArticlas[tableView.indexPathForSelectedRow!.row]
        
        let tranferDestination = segue.destination as! DetaileNewsViewController
        
        tranferDestination.articles = selectedArticl
        
        
    }
    
    func createSearchBar(){
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    func fetchArticlas(_ articls: [ArticlesDM], isSearchResult: Bool) {
        if isSearchResult {
            self.cacheArticlsData = self.newsArticlas //saving the pre loaded data
            self.newsArticlas = articls
        }else{
            self.newsArticlas = self.newsArticlas + articls
        }
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = newsArticlas.count - 1
        if indexPath.row == lastItem {
            if model.totalPage > model.currentPage {
                model.getNews(nil, 1)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        model.getNews(text, 1)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print(text )
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.newsArticlas = self.cacheArticlsData
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

}

