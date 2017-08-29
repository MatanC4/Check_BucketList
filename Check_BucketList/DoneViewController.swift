//
//  DoneViewController.swift
//  Check_BucketList
//
//  Created by Matan on 29/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DoneViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource , IndicatorInfoProvider {
    
    @IBOutlet weak var tableView: UITableView!
 
    
    var apiManager = APIManager()
    var moviesArrTrending: [Event]?
    var moviesApi = MoviesAPI()
    var selectedIndexPath: IndexPath!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
        //navigationController?.navigationBar.barTintColor = .white
        //navigationController?.navigationBar.backgroundColor = UIColor.white
        self.tableView.reloadData()
        
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
     tableView.reloadData()
     }*/
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = moviesArrTrending?.count {
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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! MyTableViewCell
        // Configure the cell...
        if moviesArrTrending != nil {
            if let event = moviesArrTrending?[indexPath.section]{
                cell.title.text = event.title
                cell.desc.text = event.desc
                cell.setUpImage(event: event)
                cell.note1.text = event.note1
                cell.note2.text = "Rate: \(event.note2!)"
                cell.backgroundColor = UIColor.lightGray
                cell.cellImage.image =   placeStatusImage(cell: cell, event: event)
            }
        }
        return cell
    }
    
    func placeStatusImage(cell:MyTableViewCell, event:Event) -> UIImage{
        if event.progresStatus == Status.TODO{
            return #imageLiteral(resourceName: "plus")
            
        }
        if event.progresStatus == Status.PENDING{
            return  #imageLiteral(resourceName: "loading")
            
        }
        if event.progresStatus == Status.DONE{
            return #imageLiteral(resourceName: "checked")
        }
        return #imageLiteral(resourceName: "plus")
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "DONE")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailsSegue"{
            let detailTVC = segue.destination as! EventTableViewController
            let cell  = tableView.cellForRow(at: selectedIndexPath ) as! MyTableViewCell
            detailTVC.image = cell.cellImage.image
            
            if let event = moviesArrTrending?[selectedIndexPath.section]{
                detailTVC.event = event
                detailTVC.titleLabel = event.title
                detailTVC.descLabel = event.desc
            }
        }
    }
    
    
    
    
}

