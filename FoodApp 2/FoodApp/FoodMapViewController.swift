//
//  FoodMapViewController.swift
//  FoodApp
//
//  Created by Brandon Campbell on 3/24/20.
//  Copyright © 2020 Washington State University. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class FoodMapViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeLocation()
        mapView.showsUserLocation = true
        findFood()
    }
    
   /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func initializeLocation() { // called from start up method
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                startLocation()
            case .denied, .restricted:
                print("location not authorized")
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
        @unknown default:
            print("IDK")
        }
    }
    
    // Delegate method called whenever location authorization status changes
    func locationManager(_ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
        if ((status == .authorizedAlways) || (status == .authorizedWhenInUse)) {
            self.startLocation()
        } else {
            self.stopLocation()
        }
    }
    
    func startLocation () {
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func stopLocation () {
        locationManager.stopUpdatingLocation()
    }
    
    // Delegate method called when location changes
    func locationManager(_ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        if let latitude = location?.coordinate.latitude {
            print("Latitude: \(latitude)")
        }
        if let longitude = location?.coordinate.longitude {
            print("Longitude: \(longitude)")
        }
    }
    
    // Delegate method called if location unavailable (recommended)
    func locationManager(_ manager: CLLocationManager,
        didFailWithError error: Error) {
        print("locationManager error: \(error.localizedDescription)")
    }
    
    func findFood() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "pizza"
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: searchHandler)
    }
    
    func searchHandler (response: MKLocalSearch.Response?, error: Error?) {
        if let err = error {
            print("Error occured in search: \(err.localizedDescription)")
        } else if let resp = response {
            print("\(resp.mapItems.count) matches found")
            self.mapView.removeAnnotations(self.mapView.annotations)
            for item in resp.mapItems {
                let annotation = MKPointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
}
