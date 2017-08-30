//
//  EventTableViewController.swift
//  Check_BucketList
//
//  Created by Matan on 12/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
    

    
    @IBOutlet weak var actionButtonNew: UIButton!
    
    @IBOutlet weak var titleView: UIView!
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        if event?.progresStatus == "PENDING" {
            self.performSegue(withIdentifier: "rateSegue", sender: self)

        }
        if event?.progresStatus == "TODO"{
            self.performSegue(withIdentifier: "addEventSegue", sender: "")

        }
    }
    @IBOutlet weak var navBar: UINavigationItem!
    @IBAction func closeSegue(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var note1Content: UILabel!
    
    var event: MyEvent?
    var image: UIImage?
    var titleLabel: String?
    var note1Label: String?
    var descLabel: String?
    var tempactionButtonNew: UIButton?
    var commit:String?
    var myCell:MyTableViewCell?
    let myGreenColor = UIColor(red:25.0,green:209.0,blue:96.0,alpha:0.0)
    private let tabelHeaderViewHeight: CGFloat = 350.0
    private let tabelHeaderViewCutAway: CGFloat = 40.0
    var headerView: EventHeaderView!
    var headerMasklayer: CAShapeLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        setHeaderView()
        setActionButtonNew()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        decideButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rateSegue"{
            let nav = segue.destination as! UINavigationController
            let rate = nav.topViewController as! RateScreen
            if let tempEvent = event{
                rate.event = tempEvent
            }
            if let title  = event?.title{
                rate.eventTempName = title
            }
            if let tempimage  = self.image{
                rate.tempImage = tempimage
            }
        }
        
        if segue.identifier == "addEventSegue"{
                let add = segue.destination as! AddEventScreen
                //let add = nav.topViewController as! AddEventScreen
                if let tempEvent = event{
                    add.event = tempEvent
                }

        }

    }
  
    func setActionButtonNew(){
        self.actionButtonNew.layer.cornerRadius = 16.0
        self.actionButtonNew.layer.masksToBounds = true
        decideButton()
    }
    
    func decideButton(){
        let status = self.event?.progresStatus
        if status == "TODO" {
            actionButtonNew.setTitle("Add", for: .normal)
            actionButtonNew.isUserInteractionEnabled = true
        }
        if status == "PENDING" {
            actionButtonNew?.backgroundColor = UIColor.orange
            actionButtonNew.setTitle("Mark Done", for: .normal)
            actionButtonNew.isUserInteractionEnabled = true
        }
        if status == "DONE" {
            actionButtonNew?.backgroundColor = UIColor.darkGray
            actionButtonNew.setTitle("Done", for: .normal)
            actionButtonNew.isUserInteractionEnabled = false
        }
    }
    
    
    func setHeaderView(){
        navigationItem.title = "Details"
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        headerView = tableView.tableHeaderView as! EventHeaderView
        headerView.image = image
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top:tabelHeaderViewHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y:
         -tabelHeaderViewHeight + 64)
        
        
        self.titleView.layer.cornerRadius = 8.0
        self.titleView.layer.masksToBounds = true
  
        
        let effectiveHeight = tabelHeaderViewHeight - tabelHeaderViewCutAway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        updateheaderView()
    }
    
    func updateheaderView(){
        let effectiveHeight = tabelHeaderViewHeight - tabelHeaderViewCutAway/2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: tabelHeaderViewHeight)
        if tableView.contentOffset.y < effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + tabelHeaderViewCutAway/2
        }
        headerView.frame = headerRect
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        path.addLine(to: CGPoint(x: 0, y: headerRect.height - tabelHeaderViewCutAway))
        headerMasklayer?.path = path.cgPath
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
        cell.titleLabel.text = titleLabel
        cell.descLabel.text = descLabel
        cell.note1.text = event?.note1
        cell.note2.text = event?.note2
        if event?.commit == ""{
            cell.commitment.text = ""
        }else{
            let tempCommit = event?.commit
            cell.commitment.text = "Commitment: \(String(describing: tempCommit)))"
        }
        //cell.backgroundColor = UIColor.darkGray
            return cell
    }
}

extension EventTableViewController{
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateheaderView()
    }
}


