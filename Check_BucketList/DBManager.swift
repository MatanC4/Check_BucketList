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

import Foundation
import CoreData
import UIKit

class DBManager  {
    
    static var eventsToDo : [MyEvent]?
    static var eventsDone : [MyEvent]?
    
    init() {
    }
    
    static func loadData(){
        self.eventsToDo = [MyEvent]()
        self.eventsDone = [MyEvent]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Check")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            var i = 0
            var j = 0
            if results.count > 0 {
                for res in results as! [NSManagedObject] {
                    let event = MyEvent()
                    if let title = res.value(forKey: "title") as? String{
                        event.title = title
                    }
                    if let thumbnailImage = res.value(forKey: "thumbnailImage") as? String{
                        event.thumbnailImage = thumbnailImage
                        
                    }
                    if let progresStatus = res.value(forKey: "progresStatus") as? String{
                        event.progresStatus = progresStatus
                        
                    }
                    if let note2 = res.value(forKey: "note2") as? String{
                        event.note2 = note2
                    }
                    if let note1 = res.value(forKey: "note1") as? String{
                        event.note1 = note1
                    }
                    if let desc = res.value(forKey: "desc") as? String{
                        event.desc = desc
                    }
                    if let commitDate = res.value(forKey: "commitDate") as? String{
                        event.commitDate = commitDate
                    }
                    if let commit = res.value(forKey: "commit") as? String{
                        event.commit = commit
                    }
                    if let userRating = res.value(forKey: "userRating") as? Float{
                        event.userRating = userRating
                    }
                    
                    
                    switch(event.progresStatus){
                        case "PENDING":
                            self.eventsToDo?.insert(event, at: i)
                            i+=1
                        case "DONE":
                            self.eventsDone?.insert(event, at: j)
                            j+=1
                        case "TODO":
                            break
                        default:
                            break
                    }
                }
               
            }
            
        }catch{
            fatalError("could not load data from core data:  \(error)")
        }
    }
    
    static func addRecordAndSave(myEvent:MyEvent){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let event = NSEntityDescription.insertNewObject(forEntityName: "Check", into: context)
        event.setValue(myEvent.title, forKey: "title")
        event.setValue(myEvent.thumbnailImage,forKey: "thumbnailImage")
        event.setValue(myEvent.progresStatus, forKey: "progresStatus")
        event.setValue(myEvent.note2, forKey: "note2")
        event.setValue(myEvent.note1, forKey: "note1")
        event.setValue(myEvent.desc, forKey: "desc")
        event.setValue(myEvent.commitDate, forKey: "commitDate")
        event.setValue(myEvent.commit, forKey: "commit")
        event.setValue(myEvent.userRating, forKey: "userRating")

        do {
            try context.save()
        }catch{
            fatalError("failed to save context: \(error)")
        }
    }
    
    
    static func deleteFromToDo(event: MyEvent){
        var i = 0
        for  item in DBManager.eventsToDo! {
            if item.title == event.title {
                DBManager.eventsToDo?.remove(at: i)
            }
            i+=1
        }
    }
    
    // clean core data
    static func deleteAllData()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Check")
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
            print("Detele all data came across with an \(error)")
        }
    }

    static func EditExistingEvent(event:MyEvent){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Check")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                for res in results as! [NSManagedObject] {
                    if event.title == res.value(forKey: "title") as? String{
                        context.delete(res)
                        addRecordAndSave(myEvent: event)
                    }
                }
            }
            
        }catch{
            fatalError("could not load data from core data:  \(error)")
        }
    }
    
}















