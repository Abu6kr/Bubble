//
//  ContentMapViewMolde.swift
//  Bubble
//
//  Created by Abobakr Al Zain  on 27.09.2023.
//

import MapKit

enum MapDetails {
    static let staringLocation = CLLocationCoordinate2D(latitude: 37.331516, longitude: -121.891054)
    static let defaulSpan = MKCoordinateSpan(latitudeDelta: 0.03,longitudeDelta: 0.03)
}


final class ContentMapViewMolde: NSObject,ObservableObject,CLLocationManagerDelegate {
 
    @Published var region = MKCoordinateRegion(center: MapDetails.staringLocation,span: MapDetails.defaulSpan)
                    
    var locationManager: CLLocationManager?
    
    func CheckIfLocationSaervesEnbled() {
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("SHOW an alert leting them Know this is off")
        }
    }
    
    private func chekLoctionAuthoiztion() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
                
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
            //MARK: your can but see all the time the loctiones
//            locationManager.requestAlwaysAuthorization()
            
        case .restricted:
            print("Your Loction is restricted likely due to parental cintrols.")
        case .denied:
            print("Your have denied this app loctiones go to setionges")
        case .authorizedAlways ,.authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MapDetails.defaulSpan)
        @unknown default:
            break
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        chekLoctionAuthoiztion()
    }
    
    
}
