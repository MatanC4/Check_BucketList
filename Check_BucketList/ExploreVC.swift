//
//  Home2.swift
//  Check_BucketList
//
//  Created by Matan on 11/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CoreData

//https://medium.com/michaeladeyeri/how-to-implement-android-like-tab-layouts-in-ios-using-swift-3-578516c3aa9

class ExploreVC: ButtonBarPagerTabStripViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var profilePic: UIImageView!
    var navBar: UINavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarButtons()
        fetchAndShapeProfilePic()
    }
    
    func fetchAndShapeProfilePic(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FBProfile")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for res in results as! [NSManagedObject] {
                    if let imageData = res.value(forKey: "image") as? NSData {
                        if let image = UIImage(data:imageData as Data) {
                            profilePic.image = image
                        }
                    }
                }
            }
        }catch{
            fatalError("could not load data from core data:  \(error)")
        }
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2;
        profilePic.layer.masksToBounds = true
        //profilePic.layer.borderWidth = 1.5
        //profilePic.layer.borderColor = UIColor.black.cgColor

    }
    
    
    func setBarButtons(){
        // change selected bar color
        self.buttonBarView.frame = CGRect(x: self.buttonBarView.frame.origin.x, y: self.buttonBarView.frame.origin.y, width: self.buttonBarView.frame.width, height: 60)
        settings.style.buttonBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemBackgroundColor = UIColor.white
        settings.style.selectedBarBackgroundColor = UIColor.black
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        //settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        //settings.style.buttonBarLeftContentInset = 0
        //settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = UIColor.black
        }
        

    }
    
   /* func setNavbar(){
        let screenSize: CGRect = UIScreen.main.bounds
         self.navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 64))
        self.view.addSubview(navBar!);
        let navItem = UINavigationItem(title: "Check");
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector));
        navItem.rightBarButtonItem = doneItem;
        navBar?.setItems([navItem], animated: false);

    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviesViewController")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TVSeriesViewController")
        
            return [child_1 , child_2]
    }
    



}
