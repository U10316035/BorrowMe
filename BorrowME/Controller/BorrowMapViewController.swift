//
//  BorrowMapViewController.swift
//  BorrowME
//
//  Created by UTaipei on 2017/9/10.
//  Copyright © 2017年 team3. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BorrowMapViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locManager: CLLocationManager?
    
    let coords = [  CLLocation(latitude: 25.0386, longitude: 121.516529),
                    CLLocation(latitude: 25.03648, longitude: 121.51231),
                    CLLocation(latitude: 25.036785, longitude:121.517),
                    CLLocation(latitude:25.035585, longitude:121.514529)
    ];
    
    let names = ["Peter" , "Tom", "Chase", "Michael"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMap()
        addAnnotations(coords: coords)
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
    
    //get user position
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
    
    //initial map
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
    
    func addAnnotations(coords: [CLLocation]){
        var i = 0
        for coord in coords{
            let CLLCoordType = CLLocationCoordinate2D(latitude: coord.coordinate.latitude,
                longitude: coord.coordinate.longitude);
            let anno = MKPointAnnotation();
            anno.coordinate = CLLCoordType;
            anno.title = names[i]
            mapView.addAnnotation(anno);
            i += 1
        }
        
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil;
        }else{
            let pinIdent = "Pin";
            var pinView: MKPinAnnotationView;
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: pinIdent) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation;
                pinView = dequeuedView;
            }else{
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinIdent);
                
            }
            return pinView;
        }
    }

}
