//
//  API Manager.swift
//  Check
//
//  Created by Matan on 21/07/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

/*import Foundation

class APIManager {
    //var moviesAPI: Movies?
    var json = [[String:AnyObject]]()
    var moviesArr = [MyEvent]()
    init() {
        
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
                        
                        //print(innerJson)
                        
                           self.parseMoviesResponse(innerJson)
                            print(self.moviesArr)
                        print("bbb")
                    }catch {
                        print("some error")
                    }
                }
            }
        }
        task.resume()
        print("aaa")
        print(self.moviesArr)
    }
    
    func parseMoviesResponse(_ responseObject: Any) {
        if let responseDictionary = responseObject as? [String:AnyObject]{
            print("Parsing JSON dictionary:\n\(responseDictionary)")
            print("########################################")
            if let results = responseDictionary["results"] as? [AnyObject]{
                //self.moviesArr = [MyEvent]()
                for movie in results{
                    let event = MyEvent()
                    event.title = movie["original_title"] as? String
                    event.desc = movie["overview"] as? String
                    event.thumbnailImage = movie["poster_path"] as? String
                    self.moviesArr.append(event)
                }
            }
        }
    }
}
*/
