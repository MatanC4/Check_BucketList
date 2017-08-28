//
//  DBManager.swift
//  Check_BucketList
//
//  Created by Matan on 28/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

//
//  DBManager.swift
//  EliranFrog
//
//  Created by Matan on 17/06/2017.
//  Copyright © 2017 Eliran Levy. All rights reserved.
//
/*
import Foundation
import MapKit
import CoreData
class DBManager  {
    
    static var eventsList : [Event] = []
    //required.addRecordI
    
    init() {
        
    }
    
    static func loadData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            var i = 0
            if results.count > 0 {
                for res in results as! [NSManagedObject] {
                    let recordItem = addRecord()
                    DBManager.eventsList.insert(recordItem, at: i)
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
                DBManager.eventsList.sort{
                    $0.score! > $1.score!
                }
                DBManager.eventsList = Array(DBManager.eventsList.prefix(RECORD_TABLE_SIZE))
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
            for x in DBManager.eventsList{
                print(x.playerName!)
                
            }
        }catch{
            fatalError("failed to save context: \(error)")
        }
    }
    
    static func addRecord(playerName: String, score: Int, long: Double ,lat: Double){
        
        let record = MyRecord(playerName: playerName , score: score , long: long ,lat: lat)
        if DBManager.eventsList.count >= RECORD_TABLE_SIZE {
            DBManager.eventsList.removeLast()
            print("The record list size is \(RECORD_TABLE_SIZE)")
        }
        DBManager.eventsList.append(record)
        DBManager.eventsList.sort{
            $0.score! > $1.score!
        }
        //deleteAllData(entity: "Record")
        self.saveData(myRecord: record)
    }
    
    
    static func getBestScore() -> Int{
        if(!eventsList.isEmpty){
            return DBManager.eventsList[0].score!
        }
        else{
            return 0
        }
    }
    
    static func isNewRecord(score: Int) -> Bool {
        if(!eventsList.isEmpty){
            if score > eventsList[(eventsList.count)-1].score! {
                return true
            }
            else {
                return false
            }
        }
        return true
    }
    
    
    // clean core data
    static func deleteAllData(entity: String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Record")
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
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    
}




*/










