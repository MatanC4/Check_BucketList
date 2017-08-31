//
//  TVSeriesViewController.swift
//  Check_BucketList
//
//  Created by Matan on 11/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TVSeriesViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource, IndicatorInfoProvider, UISearchBarDelegate{
    
    @IBOutlet weak var tvSeriesTableView: UITableView!
    var tvSeriesArr: [MyEvent]?
    var tvSeriesAPI = MoviesAPI()
    var selectedIndexPath: IndexPath!
    let trendingUrl: String = "https://api.themoviedb.org/3/tv/popular?api_key=8a5c1fef1a13c3293e4c069fde43be81&language=en-US&page=1"
    let searchUrl: String = "https://api.themoviedb.org/3/search/movie?api_key=8a5c1fef1a13c3293e4c069fde43be81&query="
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchControllerWasActive = false;
    var searchControllerSearchFieldWasFirstResponder = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.extendedLayoutIncludesOpaqueBars = !(self.navigationController?.navigationBar.isTranslucent)!
        self.tvSeriesTableView.delegate = self
        self.tvSeriesTableView.dataSource = self
        fetchFromApi(url: trendingUrl)
        self.navigationController?.isNavigationBarHidden = true
        //navigationController?.navigationBar.barTintColor = .white
        //navigationController?.navigationBar.backgroundColor = UIColor.white
        fetchFromApi(url: trendingUrl)
        searchController.searchBar.delegate = self
        
        self.searchController.searchBar.sizeToFit()
        self.tvSeriesTableView.tableHeaderView = self.searchController.searchBar
        
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search for TV Series"
        self.tvSeriesTableView.reloadData()
    }
    
    
    /*override func viewDidAppear(_ animated: Bool) {
        if (self.searchControllerWasActive) {
            
            self.searchController.active = self.searchControllerWasActive;
            self.searchControllerWasActive = NO;
            
            if (self.searchControllerSearchFieldWasFirstResponder) {
                [self.searchController.searchBar becomeFirstResponder];
                _searchControllerSearchFieldWasFirstResponder = NO;
            }
        }
    }*/
    
    /*override func viewDidAppear(_ animated: Bool) {
        tvSeriesTableView.reloadData()
    }*/
   
    func numberOfSections(in tableView: UITableView) -> Int {        
        if let count = tvSeriesArr?.count {
            return count
        }
        return 0
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
        if tvSeriesArr != nil {
            if let event = tvSeriesArr?[indexPath.section]{
                cell.title.text = event.title
                cell.desc.text = event.desc
                cell.setUpImage(event: event)
                cell.note1.text = event.note1
                cell.note2.text = "Rate: \(event.note2!)"
                //cell.backgroundColor = UIColor.darkGray
            }
        }
        return cell
    }

    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TV Series")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailsSegue"{
            let detailTVC = segue.destination as! EventTableViewController
            let cell  = tvSeriesTableView.cellForRow(at: selectedIndexPath ) as! MyTableViewCell
            detailTVC.image = cell.cellImage.image
            if let event = tvSeriesArr?[selectedIndexPath.section]{
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
            let finalKeywords = keywords.replacingOccurrences(of: "", with: "+")
            let tempSearchUrl = searchUrl+finalKeywords
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
                        self.parseResponse(innerJson)
                        self.tvSeriesTableView.reloadData()
                    }catch {
                        print("some error")
                    }
                }
            }
        }
        task.resume()
        print(tvSeriesArr as Any)
    }
    
    func parseResponse(_ responseObject: Any) {
        if let responseDictionary = responseObject as? [String:AnyObject]{
            print("Parsing JSON dictionary:\n\(responseDictionary)")
            print("########################################")
            if let results = responseDictionary["results"] as? [AnyObject]{
                self.tvSeriesArr = [MyEvent]()
                for series in results{
                    let event = MyEvent()
                    if let title = series["original_name"] as? String {
                        event.title = title
                    }else{
                        event.title = ""
                    }
                    if let desc = series["overview"] as? String{
                        event.desc = desc
                    }else{
                        event.desc = ""
                    }
                    if let releaseDate = series["first_air_date"] as? String{
                        event.note1 = releaseDate
                    }
                    if let rate = series["vote_average"] as? Float{
                        event.note2 = String(rate)
                    }
                    if let filePath = series["poster_path"] as? String {
                        event.thumbnailImage = "\(self.tvSeriesAPI.IMAGE_BASE_URL)\(String(describing : self.tvSeriesAPI.imageSizes[3]))\(filePath)"
                    }
                    tvSeriesArr!.append(event)
                }
            }
        }
    }
    
    // MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        startSearchResultsForSearchText(searchTerm: searchText)
        tvSeriesArr?.removeAll()
        self.tvSeriesTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tvSeriesTableView.reloadData()
    }
}
extension TVSeriesViewController : UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchFromApi(url: trendingUrl)
        tvSeriesArr?.removeAll()
        self.tvSeriesTableView.reloadData()
    }
}



