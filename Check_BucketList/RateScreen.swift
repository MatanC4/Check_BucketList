//
//  RateScreen.swift
//  Check_BucketList
//
//  Created by Matan on 26/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit

class RateScreen: UIViewController {
    
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var angry: UIButton!
    @IBOutlet weak var bored: UIButton!
    @IBOutlet weak var confused: UIButton!
    @IBOutlet weak var happy: UIButton!
    @IBOutlet weak var inlove: UIButton!
    
    var event:MyEvent?
    var tempImage: UIImage?
    var eventTempName: String?
    
    enum ButtonType: Int { case ang = 0, bor,conf,happ,inlo  }
    
    @IBAction func emojiTapped(_ sender: UIButton) {
        
        switch(ButtonType(rawValue: sender.tag)!){
        case .ang:
            event?.userRating = 0
        case .bor:
            event?.userRating = 1
        case .conf:
            event?.userRating = 2
        case .happ:
            event?.userRating = 3
        case .inlo:
            event?.userRating = 4
        }
        event?.progresStatus = "DONE"
        DBManager.eventsDone?.append(event!)
        DBManager.deleteFromToDo(event: event!)
        DBManager.EditExistingEvent(event: event!)
        showAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func showAlert()  {
        let alert = UIAlertController(title: "", message: "Thanks for rating \(eventTempName!)", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Next please", style: UIAlertActionStyle.default, handler: { action in self.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func skipTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUI(){
        self.eventImage.image = tempImage
        self.eventImage.layer.cornerRadius = 8.0
        self.eventImage.layer.masksToBounds = true
        self.eventName.text = eventTempName
    }
}
