//
//  MapViewController.swift
//  BorrowME
//
//  Created by UTaipei on 2017/9/8.
//  Copyright © 2017年 team3. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var locManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMap()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //get location
    @IBAction func locationButtonAct(_ sender: Any) {
        getCurrentLocation()
        print("in")
    }
    
    func getCurrentLocation (){
        if locManager != nil{
            let currLocation = locManager!.location
            if currLocation == nil {
                return
            }
            let currentLocationSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let currcoor = currLocation?.coordinate
            
            let center:CLLocation = CLLocation(latitude: (currcoor?.latitude)!, longitude: (currcoor?.longitude)!)
            let currentRegion = MKCoordinateRegion(center: center.coordinate, span: currentLocationSpan)
            //print(center.coordinate)
            mapView.setRegion(currentRegion, animated: true)
        }
    }
    
    func initMap(){
        self.locManager = CLLocationManager()
        self.locManager!.requestWhenInUseAuthorization()
        self.locManager!.delegate = self
        //地圖類型是標準的
        self.mapView.mapType = .standard
        //顯示自己的位置
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        self.mapView.isZoomEnabled = true
        
        
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.locManager!.desiredAccuracy = kCLLocationAccuracyBest
            self.locManager!.startUpdatingLocation()
        }
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.locManager!.desiredAccuracy = kCLLocationAccuracyBest
            self.locManager!.startUpdatingLocation()
        }
        
        let currLocation = self.locManager!.location
        
        func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
            
        }
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .authorizedWhenInUse {
                self.locManager!.desiredAccuracy = kCLLocationAccuracyBest
                self.locManager!.startUpdatingLocation()
            }
        }
        self.getCurrentLocation()
    }
    
}
