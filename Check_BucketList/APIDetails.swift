//
//  APIDetails.swift
//  Check_BucketList
//
//  Created by Matan on 10/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import Foundation

class MoviesAPI : NSObject{
    let BASE_URL : String =  "https://api.themoviedb.org/3/"
    let API_KEY : String = "8a5c1fef1a13c3293e4c069fde43be81"
    var englishInputLang : String =  "en-US"
    let  popularMethod: String = "movie/popular?api_key="
    let languagePrefix : String = "&language=en-US"
    var pagePrefix : String = "&page=1"
    let imageSizes =  ["w92", "w154", "w185", "w342", "w500", "w780", "original"]
    let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/"
    
    override init() {
        
    }
    
   /* https://image.tmdb.org/t/p/w500/gwPSoYUHAKmdyVywgLpKKA4BjRr.jpg
    
    //https://api.themoviedb.org/3/tv/w185?/api_key=8a5c1fef1a13c3293e4c069fde43be81/gwPSoYUHAKmdyVywgLpKKA4BjRr.jpg
    // event.thumbnailImage = "\(self.moviesApi.IMAGE_BASE_URL)\(String(describing : self.moviesApi.imageSizes[3]))\(filePath)"

    https://api.themoviedb.org/3/tv/{tv_id}?api_key=<<api_key>>&language=en-US*/
}


