//
//  EventDetails.swift
//  Check_BucketList
//
//  Created by Matan on 12/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit

class EventHeaderView: UIView{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionButtonNew: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var event : Event?
    
    init()
    {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0 ))
    }
    convenience init (withEvent event: Event)
    {
        self.init()
        setActionButtonNew()
        self.event = event
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var image : UIImage? {
        didSet {
            if let image = image {
                imageView.image = image
            }else{
                imageView.image = nil
            }
        }
    }
    func setActionButtonNew(){
        
        self.actionButtonNew.layer.cornerRadius = 16.0
        self.actionButtonNew.layer.masksToBounds = true
        
        event?.progresStatus = Status.TODO
        let status = event?.progresStatus
        if status == Status.TODO {
            actionButtonNew.setTitle("Add", for: .normal)
        }
        if status == Status.PENDING {
            actionButtonNew?.backgroundColor = UIColor.orange
            actionButtonNew.setTitle("Mark Done", for: .normal)
        }
        if status == Status.DONE {
            actionButtonNew?.backgroundColor = UIColor.darkGray
            actionButtonNew.setTitle("Done", for: .normal)
        }
        
    }
    
    
}
