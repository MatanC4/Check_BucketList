//
//  AddEventScreen.swift
//  Check_BucketList
//
//  Created by Matan on 27/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit

class AddEventScreen: UIViewController, UITextFieldDelegate {
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var textBox: UITextField!
    var eventTitle: String?
    var eventDate: String?
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    var event:MyEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //doneBtn.isEnabled = false
        textBox.delegate = self
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd , YYYY"
        event?.commitDate = formatter.string(from: datePicker.date)
        print(event?.commitDate! as Any)
    }
    
    
    
    @IBAction func doneTapped(_ sender: Any) {
        if (textBox.text?.isEmpty)!{
            showErrorAlert()
        }
        else{
            if event != nil{
                event?.commit = textBox.text
                event?.progresStatus = "PENDING"
                DBManager.eventsToDo?.append(event!)
                DBManager.addRecordAndSave(myEvent: event!)
                DBManager.loadData()
                showEventAddedAlert()
            }else{
                print("Event\(String(describing: event?.title!)) is nil")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        doneBtn.isEnabled = true
    }
    
    
    func showErrorAlert()  {
        let alert = UIAlertController(title: "Missing Commitment", message: "Please enter your commitment", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showEventAddedAlert()  {
        self.eventDate = event?.commitDate
        self.eventTitle = event?.title
        let alert = UIAlertController(title: "Check Added", message: "You added \(eventTitle!) to your Checks. \nYou have until \(eventDate!) to complete it", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
            
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
