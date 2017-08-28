//
//  Home2.swift
//  Check_BucketList
//
//  Created by Matan on 11/08/2017.
//  Copyright © 2017 Matan. All rights reserved.
//

import UIKit
import XLPagerTabStrip

//https://medium.com/michaeladeyeri/how-to-implement-android-like-tab-layouts-in-ios-using-swift-3-578516c3aa9

class MyChecks: ButtonBarPagerTabStripViewController {
    
    
    var navBar: UINavigationBar?
    //let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width:, height: 64))
    //let moviesViewController: MoviesViewController = MoviesViewController()
    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // change selected bar color
        settings.style.buttonBarBackgroundColor = UIColor.lightGray
        settings.style.buttonBarItemBackgroundColor = UIColor.lightGray
        settings.style.selectedBarBackgroundColor = UIColor.black
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = UIColor.black
        }
        //navBar?.backgroundColor = UIColor.green
        setNavbar()
       // profilePic.layer.cornerRadius = profilePic.frame.size.width / 2;
       // profilePic.layer.masksToBounds = true
       // profilePic.layer.borderWidth = 1.5
       // profilePic.layer.borderColor = UIColor.black.cgColor
        
        
    }
    
    
    func setNavbar(){
        let screenSize: CGRect = UIScreen.main.bounds
        self.navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 64))
        self.view.addSubview(navBar!);
        let navItem = UINavigationItem(title: "Check");
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector));
        navItem.rightBarButtonItem = doneItem;
        navBar?.setItems([navItem], animated: false);
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MoviesViewController")
        
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TVSeriesViewController")
        
        return [child_1, child_2]
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
