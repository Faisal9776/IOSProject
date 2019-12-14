//
//  MapViewController.swift
//  EasyParking
//
//  Created by Jun K on 2019-12-13.
//  Copyright © 2019 The Coders. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    var locationManager = CLLocationManager()
    var regionRadius: CLLocationDistance = 100
    
    @IBOutlet var myMap : MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //setup map appearance
        myMap.mapType = MKMapType.satellite
        myMap.isZoomEnabled = true
        myMap.isScrollEnabled = true
        myMap.isUserInteractionEnabled = true
        
        //set up locationmanager properties
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        //start getting the location updates using the callback created
        if (CLLocationManager.locationServicesEnabled()){
            locationManager.startUpdatingLocation()
        }
    }
    

    @IBAction func doSearchNearby(){
        //search for the nearby facilities surrounding the current location
        
        //create a request to be provided to the location manager
        let request = MKLocalSearch.Request()
        let keyword = "Parking"
        request.naturalLanguageQuery = keyword
        
        //for a span within which you want to search the facility
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        
        //set the center of the map to be searched
        let centerCoordinate = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        
        //set the region for the request
        request.region = MKCoordinateRegion(center: centerCoordinate, span: span)
        
        //execute the search request
        let search = MKLocalSearch(request: request)
        
        //start searching and handle the response (completion or failure)
        search.start(completionHandler: {(response, error) in
            guard let response = response else{
                //if doen't get any response from search operation
                //if failure occurs
                print("error : \(error?.localizedDescription ?? "Unknown error happened.")")
                return
            }
            
            //if success in finding the nearby locations
            for item in response.mapItems{
                self.addPinToMap(title: item.name, lat: item.placemark.location!.coordinate.latitude, long: item.placemark.location!.coordinate.longitude)
            }
            
            //zoom out the map
            var region : MKCoordinateRegion = self.myMap.region
            var span : MKCoordinateSpan = self.myMap.region.span
            span.latitudeDelta *= 8
            span.longitudeDelta *= 8
            region.span = span
            self.myMap.setRegion(region, animated: true)
            
        })
    }
}

extension MapViewController : CLLocationManagerDelegate{
    
    //print an error if anything goes wrong
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    //handles the changes in the permission for location access
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            //when permission is given for location access while app is running ask the location manager to get the current location
            locationManager.requestLocation()
        case .authorizedAlways:
            //code to operate in background using location access
            break
        case .denied:
            //operations to be done if permission is denied
            //for example, go to settings and change permissions
            //display Alert using various possibilities or limitation of facilities
            break
        case .notDetermined:
            //if user has neither approved nor rejected permission
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestLocation()
        @unknown default:
            break
        }
    }
    
    //handles location requests and updates
    //also display the location on Map
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //if any previous locations are available get most recent one
        //You may optionally display the location on map instead of displaying on console
        if locations.last != nil{
            print("location :: \(locations.last)")
        }
        
        print("Updating location")
        
        //create a center point of our location to be displayed on map using current latitude and longitude
        let center = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        
        print("center : \(center)")
        
        //create a region to be displayed on map using the 2D coordinates
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        //display the region on map
        self.myMap.setRegion(region, animated: true)
        
        //Drop a pin at user's current location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = center //where to display...provide 2D coordinates...Lat and Long
        myAnnotation.title = "You are here !"
        
        //add the pin on the map
        myMap.addAnnotation(myAnnotation)
    }
    
    func addPinToMap(title: String?, lat: CLLocationDegrees, long: CLLocationDegrees){
        if let title = title{
            let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let myAnnotation = MKPointAnnotation()
            myAnnotation.coordinate = location
            myAnnotation.title = title
            self.myMap.addAnnotation(myAnnotation)
            

        }
    }
}
    

    


