//
//  MyTableView.swift
//  Check_BucketList
//
//  Created by Matan on 08/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var actionButton: UIButton!
    
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var note1: UILabel!
    
    @IBOutlet weak var note2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setUpImage(event:MyEvent){
        if event.thumbnailImage != nil {
            let thumbnailImage = event.thumbnailImage
            if let url = URL(string: thumbnailImage!)
            {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if error != nil{
                        print(error!)
                    }
                    else {
                        if data != nil{
                            
                            DispatchQueue.global(qos: .userInitiated).async {
                                // Bounce back to the main thread to update the UI
                                DispatchQueue.main.async {
                                    self.cellImage.layer.cornerRadius = 5.0
                                    self.cellImage.layer.masksToBounds = true
                                    self.cellImage.image = UIImage(data: data!)
                                }
                            }
                        }
                    }
                    }.resume()
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.image = nil
    }
    
}
