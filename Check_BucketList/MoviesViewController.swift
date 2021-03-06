//
//  Movies.swift
//  Check_BucketList
//
//  Created by Matan on 11/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MoviesViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource , IndicatorInfoProvider , UISearchBarDelegate {
    
    @IBOutlet weak var moviesTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var moviesArrTrending: [MyEvent]?
    var moviesApi = MoviesAPI()
    var selectedIndexPath: IndexPath!
    let trendingUrl: String = "https://api.themoviedb.org/3/movie/popular?api_key=8a5c1fef1a13c3293e4c069fde43be81&language=en-US&page=1"
    let searchUrl: String = "https://api.themoviedb.org/3/search/movie?api_key=8a5c1fef1a13c3293e4c069fde43be81&query="

    override func viewDidLoad() {
        super.viewDidLoad()
        self.extendedLayoutIncludesOpaqueBars = !(self.navigationController?.navigationBar.isTranslucent)!
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        fetchFromApi(url: trendingUrl)
        self.navigationController?.isNavigationBarHidden = true
        fetchFromApi(url: trendingUrl)
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        moviesTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.placeholder = "Search for Movies"
        self.moviesTableView.reloadData()
        
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        moviesTableView.reloadData()
    }*/
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        if let count = moviesArrTrending?.count {
            return count
        }
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "ShowDetailsSegue", sender: "")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! MyTableViewCell
        // Configure the cell...
        if moviesArrTrending != nil {
            if let event = moviesArrTrending?[indexPath.section]{
                cell.title.text = event.title
                cell.desc.text = event.desc
                cell.setUpImage(event: event)
                cell.note1.text = event.note1
                cell.note2.text = "Rate: \(event.note2!)"
                //cell.backgroundColor = UIColor.lightGray
                //cell.cellImage.image =  placeStatusImage(cell: cell, event: event)
            }
        }
        return cell
    }
    
    func placeStatusImage(cell:MyTableViewCell, event:MyEvent) -> UIImage{
        if event.progresStatus == "TODO"{
            return #imageLiteral(resourceName: "plus")
            
        }
        if event.progresStatus == "PENDING"{
            return  #imageLiteral(resourceName: "loading")
            
        }
        if event.progresStatus == "DONE"{
            return #imageLiteral(resourceName: "checked")
        }
        return #imageLiteral(resourceName: "picture")
    }

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Movies")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailsSegue"{
            let detailTVC = segue.destination as! EventTableViewController
            let cell  = moviesTableView.cellForRow(at: selectedIndexPath ) as! MyTableViewCell
            detailTVC.image = cell.cellImage.image
            
           if let event = moviesArrTrending?[selectedIndexPath.section]{
                detailTVC.event = event
                detailTVC.titleLabel = event.title
                detailTVC.descLabel = event.desc
            }
        }
    }
    
    func  startSearchResultsForSearchText(searchTerm: String){
        if searchTerm == ""{
            fetchFromApi(url: trendingUrl)
        }else{
            let keywords = searchTerm
            let trimmedkeywords = keywords.trimmingCharacters(in: .whitespacesAndNewlines)
            print("$$$$$$$$$$$$$  *\(trimmedkeywords)*")
            let finalKeywords = trimmedkeywords.replacingOccurrences(of: " ", with: "+")
            print("$$$$$$$$$$$$$  *\(finalKeywords)*")
            let tempSearchUrl = searchUrl+finalKeywords
            print("$$$$$$$$$$$$$  *\(tempSearchUrl)*")
            fetchFromApi(url: tempSearchUrl)
        }
    }
    func fetchFromApi(url:String){
        let poplularMoviesUrl = URL(string: url)
          let task = URLSession.shared.dataTask(with: poplularMoviesUrl!) { (data, response, error) in
            if error != nil{
                print(error!)
            }
            else {
                if data != nil{
                    do{
                        let innerJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                        DispatchQueue.main.async {
                            self.parseResponse(innerJson)
                            self.moviesTableView.reloadData()
                        }
                    }catch {
                        print("some error")
                    }
                }
            }
        }
        task.resume()    }
    
    func parseResponse(_ responseObject: Any) {
        if let responseDictionary = responseObject as? [String:AnyObject]{
            print("Parsing JSON dictionary:\n\(responseDictionary)")
            print("########################################")
            if let results = responseDictionary["results"] as? [AnyObject]{
                self.moviesArrTrending = [MyEvent]()
                for movie in results{
                    let event = MyEvent()
                    if let title = movie["original_title"] as? String {
                    event.title = title
                    }else{
                        event.title = ""
                    }
                    if let desc = movie["overview"] as? String{
                        event.desc = desc
                    }else{
                        event.desc = ""
                    }
                    if let releaseDate = movie["release_date"] as? String{
                        event.note1 = releaseDate
                    }
                    if let rate = movie["vote_average"] as? Float{
                        event.note2 = String(rate)
                    }
                    
                    if let filePath = movie["poster_path"] as? String {
                      event.thumbnailImage = "\(self.moviesApi.IMAGE_BASE_URL)\(String(describing : self.moviesApi.imageSizes[4]))\(filePath)"
                      print(event.thumbnailImage! as String)
                    }else{
                        event.thumbnailImage = ""
                    }
                    moviesArrTrending!.append(event)
                }
            }
        }
    }
    
// MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        startSearchResultsForSearchText(searchTerm: searchText)
        moviesArrTrending?.removeAll()
        self.moviesTableView.reloadData()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.moviesTableView.reloadData()
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchFromApi(url: trendingUrl)
        moviesArrTrending?.removeAll()
        self.moviesTableView.reloadData()
    }
}

