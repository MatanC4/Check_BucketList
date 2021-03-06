//
//  TODOViewController.swift
//  Check_BucketList
//
//  Created by Matan on 29/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class TODOViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource , IndicatorInfoProvider {
    
    @IBOutlet weak var tableView: UITableView!
    var moviesApi = MoviesAPI()
    var selectedIndexPath: IndexPath!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
     tableView.reloadData()
     }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = DBManager.eventsToDo?.count {
            return count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "ShowDetailsSegue", sender: "")
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! MyTableViewCell
        // Configure the cell...
        if DBManager.eventsToDo != nil {
            if let event = DBManager.eventsToDo?[indexPath.section]{
                cell.title.text = event.title
                cell.desc.text = event.desc
                cell.setUpImage(event: event)
                cell.note1.text = event.note1
                cell.note2.text = "Rate: \(event.note2!)"
                //cell.backgroundColor = UIColor.darkGray
                cell.cellImage.image =   placeStatusImage(cell: cell, event: event)
            }
        }
        return cell
    }
    
    func placeStatusImage(cell:MyTableViewCell, event:MyEvent) -> UIImage{
        if event.progresStatus == "TODO"{
            return #imageLiteral(resourceName: "plus")
            
        }
        if event.progresStatus == "PENDING"{
            return  #imageLiteral(resourceName: "loading")
            
        }
        if event.progresStatus == "DONE"{
            return #imageLiteral(resourceName: "checked")
        }
        return #imageLiteral(resourceName: "picture")
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "TO DO")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailsSegue"{
            let detailTVC = segue.destination as! EventTableViewController
            let cell  = tableView.cellForRow(at: selectedIndexPath ) as! MyTableViewCell
            detailTVC.image = cell.cellImage.image
            
            if let event = DBManager.eventsToDo?[selectedIndexPath.section]{
                detailTVC.event = event
                detailTVC.titleLabel = event.title
                detailTVC.descLabel = event.desc
            }
        }
    }
}

