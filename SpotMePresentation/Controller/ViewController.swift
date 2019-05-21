//
//  ViewController.swift
//  SpotMePresentation
//
//  Created by Jeffery Widroff on 6/3/18.
//  Copyright © 2018 Jeffery Widroff. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

let usersLookingNotificationKey = "usersLooking"
let closestCheapestNotificationKey = "closestCheapest"
let getASpotNotificationKey = "getASpot"
let giveASpotNotificationKey = "giveASpot"

let closestCheapestNotificationName = Notification.Name(rawValue: closestCheapestNotificationKey)
let usersLookingNotificationName = Notification.Name(rawValue: usersLookingNotificationKey)
let getASpotNotificationName = Notification.Name(rawValue: getASpotNotificationKey)
let giveASpotNotificationName = Notification.Name(rawValue: giveASpotNotificationKey)


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var giveASpotBtn: UIButton!
    @IBOutlet weak var getASpotBtn: UIButton!
    
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var saveMySpotBtn: UIButton!
    
    @IBOutlet weak var closestCheapestBtn: UIButton!
    @IBOutlet weak var usersLookingBtn: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

    var screenWasTapped = true
    
    var getASpot = GetASpot()
    var giveASpot = GiveASpot()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        makeRound(view: closestCheapestBtn)
        makeRound(view: usersLookingBtn)
        makeRound(view: settingsBtn)
        makeRound(view: saveMySpotBtn)
        makeRound(view: giveASpotBtn)
        makeRound(view: getASpotBtn)
        
        closestCheapestBtn.alpha = 0
        usersLookingBtn.alpha = 0
        settingsBtn.alpha = 0
        saveMySpotBtn.alpha = 0

        tapGestureRecognizer()
        createObservers()
        //mapView.showsCompass = false
        
    }
    
    // Makes a view round
    func makeRound(view: UIView) {
        view.layer.cornerRadius = view.frame.height / 2
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0] // the last location the user was in
        let center = location.coordinate // MKCoordinateRegion requires this
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        
    }
    
    func tapGestureRecognizer(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        mapView.addGestureRecognizer(tapGestureRecognizer)
        mapView.isUserInteractionEnabled = true
        
    }
    
    func createObservers() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.determineOptions(notification:)), name: giveASpotNotificationName, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.determineOptions(notification:)), name: getASpotNotificationName, object: nil)
    }

    @objc func determineOptions(notification: Notification){
        
        let getASpotWasPressed = notification.name == getASpotNotificationName
        if getASpotWasPressed{
            alert(title: getASpot.alertTitle, message: getASpot.alertMessage)
        } else {
            alert(title: giveASpot.alertTitle, message: giveASpot.alertMessage)
        }
    }
    
    func alert(title: String, message: String){

        let title = title
        let message = message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }

    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        if screenWasTapped == true {
            
            closestCheapestBtn.alpha = 0.7
            usersLookingBtn.alpha = 0.7
            settingsBtn.alpha = 0.7
            saveMySpotBtn.alpha = 0.7
            changeColor(view: closestCheapestBtn)
            changeColor(view: usersLookingBtn)
            changeColor(view: settingsBtn)
            changeColor(view: saveMySpotBtn)
            screenWasTapped = false
            
        } else {
            
            closestCheapestBtn.alpha = 0
            usersLookingBtn.alpha = 0
            settingsBtn.alpha = 0
            saveMySpotBtn.alpha = 0
            screenWasTapped = true
        }
    }

    func changeColor(view: UIView) {
        
        let red = CGFloat(arc4random_uniform(256)) / 255
        let blue = CGFloat(arc4random_uniform(256)) / 255
        let green = CGFloat(arc4random_uniform(256)) / 255
        let imageColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        view.backgroundColor = imageColor
    }
    
    func bounceButton(button: UIButton){
       
        button.transform = CGAffineTransform(scaleX: 1.9, y: 1.9)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .allowUserInteraction, animations: {
            button.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func rotateButton(button: UIButton){
        
        button.transform = CGAffineTransform(rotationAngle: 180.0)
        UIView.animate(withDuration: 5.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.5, options: .allowUserInteraction, animations: {
            button.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func moveButton(button: UIButton){
        
        button.transform = CGAffineTransform(translationX: button.center.x - 30, y: button.center.y - 30)
        UIView.animate(withDuration: 10.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.5, options: .allowUserInteraction, animations: {
            button.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func coolButton(button: UIButton){
        
        button.transform = CGAffineTransform(a: 0.5, b: 0.5, c: 0.7, d: 0.2, tx: 5.0, ty: -5.0)
        UIView.animate(withDuration: 10.5, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.5, options: .allowUserInteraction, animations: {
            button.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func presentPopUP() {
        
        let popUpViewVC = storyboard?.instantiateViewController(withIdentifier: "popUpViewVC") as! PopUpViewController
        present(popUpViewVC, animated: true, completion: nil)
        
    }
    
    @IBAction func usersLookingPressed(_ sender: Any) {
        presentPopUP()
        NotificationCenter.default.post(name: usersLookingNotificationName, object: nil)
    }

    @IBAction func closestCheapestPressed(_ sender: Any) {
        presentPopUP()
        NotificationCenter.default.post(name: closestCheapestNotificationName, object: nil)
    }
    
    @IBAction func getASpotPressed(_ sender: Any) {
        
        NotificationCenter.default.post(name: getASpotNotificationName, object: nil)
        bounceButton(button: getASpotBtn)

    }
    @IBAction func giveASpotPressed(_ sender: Any) {
        
        NotificationCenter.default.post(name: giveASpotNotificationName, object: nil)
        rotateButton(button: giveASpotBtn)
    }
    
    @IBAction func settingsBtnPressed(_ sender: Any) {
        moveButton(button: settingsBtn)
    }
    
    @IBAction func saveMySpotPressed(_ sender: Any) {
        coolButton(button: saveMySpotBtn)
    }
    
    
}

