//
//  ViewController.swift
//  Check_BucketList
//
//  Created by Matan on 05/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import CoreData


class ViewController: UIViewController {
    var userName: String? = ""
    
    @IBAction func anonymousLoginTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "mainScreenSegue", sender: self)
    }
    @IBOutlet weak var anonymousLoginBtn: UIButton!
    
    var profilePic: UIImageView? = UIImageView()
    var imageurl: String?
    
    @IBOutlet weak var fbLoginBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shapeButtons()
        //deleteImage()
    }

    func shapeButtons(){
        fbLoginBtn.layer.cornerRadius = 7.0
        fbLoginBtn.layer.masksToBounds = true
        anonymousLoginBtn.layer.cornerRadius = 7.0
        anonymousLoginBtn.layer.masksToBounds = true
    }
    @IBAction func fbButtonTapped(_ sender: UIButton) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if(fbloginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    self.performSegue(withIdentifier: "mainScreenSegue", sender: self)
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    print(result!)
                    if let responseDictionary = result as? [String:AnyObject]{
                        self.userName = responseDictionary["name"] as? String
                        let userID = responseDictionary["id"] as! String
                            let facebookProfileUrl = "https://graph.facebook.com/\(userID)/picture?type=large"
                            self.getImage( url: facebookProfileUrl, profilePicture: self.profilePic!)
                    }
                    
                }
            })
        }
    }
    
 
    
func saveImage(image: UIImage){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let result = NSEntityDescription.insertNewObject(forEntityName: "FBProfile", into: context)
    
    let imgData = UIImageJPEGRepresentation(image, 1)
    result.setValue(imgData, forKey: "image")
    result.setValue(userName , forKey: "user_name")
    do {
        try context.save()
        }catch{
        fatalError("failed to save context: \(error)")
    }
}

func getImage(url: String , profilePicture: UIImageView){
        let imageUrl = URL(string: url)
        URLSession.shared.dataTask(with: imageUrl!) { (data, response, error) in
            if error != nil{
                print(error!)
            }
            else {
                if data != nil{
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        // Bounce back to the main thread to update the UI
                        DispatchQueue.main.async {
                            //self.profilePic.image = UIImage(data: data!)
                            print(data!)
                           profilePicture.image = UIImage(data: data!)
                            print("i should have the photo now :)")
                            self.saveImage(image: profilePicture.image!)
                        }
                    }
                }
            }
            }.resume()
}
    
    
    
    
    
    //debug use only
    
    func deleteImage(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FBProfile")
        fetchRequest.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                context.delete(managedObjectData)
                print("data deleted")
            }
        } catch let error as NSError {
            print(" error : \(error) \(error.userInfo)")
        }
    }


}
/*
static func loadData(){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
    request.returnsObjectsAsFaults = false
    
    do {
        let results = try context.fetch(request)
        var i = 0
        if results.count > 0 {
            for res in results as! [NSManagedObject] {
                let recordItem = MyRecord()
                RecordManager.recordList.insert(recordItem, at: i)
                if let username = res.value(forKey: "username") as? String{
                    recordItem.playerName = username
                }
                if let score = res.value(forKey: "score") as? Int{
                    recordItem.score = score
                    
                }
                if let long = res.value(forKey: "long") as? Double{
                    recordItem.long = long
                    
                }
                if let lat = res.value(forKey: "lat") as? Double{
                    recordItem.lat = lat
                }
                i += 1
                
            }
            RecordManager.recordList.sort{
                $0.score! > $1.score!
            }
            RecordManager.recordList = Array(RecordManager.recordList.prefix(RECORD_TABLE_SIZE))
        }
        
    }catch{
        fatalError("could not load data from core data:  \(error)")
    }
    
}

static func saveData(myRecord: MyRecord){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    let record = NSEntityDescription.insertNewObject(forEntityName: "Record", into: context)
    record.setValue(myRecord.playerName, forKey: "username")
    record.setValue(myRecord.score, forKey: "score")
    record.setValue(myRecord.long, forKey: "long")
    record.setValue(myRecord.lat, forKey: "lat")
    
    do {
        try context.save()
        //debug
        for x in RecordManager.recordList{
            print(x.playerName!)
            
        }
    }catch{
        fatalError("failed to save context: \(error)")
    }
}

*/







