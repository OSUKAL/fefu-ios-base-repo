//
//  ViewController.swift
//  iughj
//
//  Created by wsr2 on 27.10.2021.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController {

    let idCell = "tableCell"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TableViewItem", bundle: nil), forCellReuseIdentifier: idCell)
    }
    
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var label1Hide: UILabel!
    @IBOutlet weak var label2Hide: UILabel!
    
    @IBAction func Hide(_ sender: UIButton) {
        hideView.isHidden = true
        label1Hide.isHidden = true
        label2Hide.isHidden = true
    }
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! TableViewItem

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Вчера"
        }
        else {
             return "Май 2022 года"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Info")
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}


class MapNavigation: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        
        manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        return manager
    }()
    
    var userLocation: CLLocation? {
        didSet{
            guard let userLocation = userLocation else {
                return
            }
            
            let region = MKCoordinateRegion(center: userLocation.coordinate,
                                            latitudinalMeters: 500,
                                            longitudinalMeters: 500)
            
            mapView.setRegion(region, animated: true)
            
            userLocationsHistory.append(userLocation)
        }
    }
    
    fileprivate var userLocationsHistory: [CLLocation] = [] {
        didSet {
            let coordinates = userLocationsHistory.map { $0.coordinate }
            
            let route = MKPolyline(coordinates: coordinates, count: coordinates.count)
            
            route.title = "Ваш маршрут"
            
            mapView.addOverlay(route)
        }
    }
    
    private let userLocationIdentifier = "user_icon"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
    }
}

extension MapNavigation: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first else {
            return
        }
        
        print("received device location:", currentLocation.coordinate)
        userLocation = currentLocation
    }
}

extension MapNavigation: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let render = MKPolylineRenderer(polyline: polyline)
            render.fillColor = UIColor.blue
            render.strokeColor = UIColor.blue
            render.lineWidth = 4
            
            return render
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? MKUserLocation {
            let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: userLocationIdentifier)
            
            let view = dequedView ?? MKAnnotationView(annotation: annotation, reuseIdentifier: userLocationIdentifier)
            
            view.image = UIImage(named: "ic_user_location")
            
            return view
        }
        
        return nil
    }
}



