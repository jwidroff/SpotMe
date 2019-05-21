//
//  PopUpViewController.swift
//  SpotMePresentation
//
//  Created by Jeffery Widroff on 6/10/18.
//  Copyright © 2018 Jeffery Widroff. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var button: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        createObservers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(PopUpViewController.determineOptions(notification:)), name: closestCheapestNotificationName, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(PopUpViewController.determineOptions(notification:)), name: usersLookingNotificationName, object: nil)
    }

    @objc func determineOptions(notification: Notification){
        
        let isUsersLooking = notification.name == usersLookingNotificationName
        button.backgroundColor = isUsersLooking ? UIColor.blue : UIColor.red
    }
    
    @IBAction func backBtn(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
        
    }
}
