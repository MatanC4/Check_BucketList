//
//  Event.swift
//  Check
//
//  Created by Matan on 21/07/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit

class MyEvent: NSObject {
    
    var thumbnailImage: String?
    var title: String?
    var category: Categories?
    var desc: String?
    var progresStatus: String = "TODO"
    var note1: String?
    var note2: String?
    var userRating: Float?
    var commit: String?
    var commitDate: String?
    
    override init() {
        super.init()
        self.thumbnailImage = ""
        self.title = ""
        self.category = Categories.Default
        self.desc = ""
        self.note1 = ""
        self.note2 = ""
        self.commit = ""
        self.commitDate = ""
    
    }
    
    init(thumbnailImage: String , title: String ,subtitle: String ,note: String, category: Categories , desc: String ) {
        self.thumbnailImage = thumbnailImage
        self.title = title
        self.category = category
        self.desc = desc
    
    }
    
}


