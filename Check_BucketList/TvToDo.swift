//
//  TvToDo.swift
//  Check_BucketList
//
//  Created by Matan on 18/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit
import XLPagerTabStrip


class TvToDo: UIViewController , UITableViewDelegate , UITableViewDataSource  {

    @IBOutlet weak var myTableView: UITableView!
    var apiManager = APIManager()
    var moviesArr: [Event]?
    var moviesApi = MoviesAPI()
    var selectedIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        //navigationController?.navigationBar.barTintColor = .white
        //navigationController?.navigationBar.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        fetchMoviesfromApi()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = moviesArr?.count {
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
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! MyTableViewCell
        
        // Configure the cell...
        if !(moviesArr?.isEmpty)! {
            let event = moviesArr?[indexPath.section]
            cell.title.text = event?.title
            cell.desc.text = event?.desc
            cell.setUpImage(event: event!)
            cell.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailsSegue"{
            let detailTVC = segue.destination as! EventTableViewController
            let cell  = myTableView.cellForRow(at: selectedIndexPath ) as! MyTableViewCell
            detailTVC.image = cell.cellImage.image
            if let event = moviesArr?[selectedIndexPath.section]{
                detailTVC.titleLabel = event.title
                detailTVC.descLabel = event.desc
                
            }
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TV Series")
    }
    
    
    func fetchMoviesfromApi(){
        //       let url = URL(string: "\(String(describing: moviesAPI?.BASE_URL)),\(String(describing: moviesAPI?.popularMethod)),\(String(describing:  moviesAPI?.API_KEY)), \(String(describing: moviesAPI?.languagePrefix)),\(String(describing: moviesAPI?.pagePrefix)) " )
        
        //        let url = NSURL(string: "\(#imageLiteral(resourceName: "movies").BASE_URL),\(#imageLiteral(resourceName: "movies").pop) " getPopularMethod + API_KEY + languagePrefix + pagePrefix)
        //"https://api.themoviedb.org/3/movie/popular?api_key=8a5c1fef1a13c3293e4c069fde43be81&language=en-US&page=1"
        
        let url: String = "https://api.themoviedb.org/3/movie/popular?api_key=8a5c1fef1a13c3293e4c069fde43be81&language=en-US&page=1"
        
        
        let poplularMoviesUrl = URL(string: url)
        //print(poplularMoviesUrl as Any)
        let task = URLSession.shared.dataTask(with: poplularMoviesUrl!) { (data, response, error) in
            if error != nil{
                print(error!)
            }
            else {
                if data != nil{
                    do{
                        let innerJson = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                        self.parseMoviesResponse(innerJson)
                        self.myTableView.reloadData()
                        
                    }catch {
                        print("some error")
                    }
                }
            }
        }
        task.resume()
    }
    
    func parseMoviesResponse(_ responseObject: Any) {
        if let responseDictionary = responseObject as? [String:AnyObject]{
            print("Parsing JSON dictionary:\n\(responseDictionary)")
            print("########################################")
            if let results = responseDictionary["results"] as? [AnyObject]{
                self.moviesArr = [Event]()
                for movie in results{
                    let event = Event()
                    event.title = movie["original_title"] as? String
                    event.desc = movie["overview"] as? String
                    //event. = movie["vote_average"] as? String
                    let filePath = movie["poster_path"] as! String
                    event.thumbnailImage = "\(self.moviesApi.IMAGE_BASE_URL)\(String(describing : self.moviesApi.imageSizes[4]))\(filePath)"
                    print(event.thumbnailImage! as String)
                    moviesArr!.append(event)
                }
            }
        }
    }


}
