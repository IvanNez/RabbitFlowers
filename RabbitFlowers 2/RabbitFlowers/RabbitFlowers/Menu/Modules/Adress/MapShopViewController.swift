//
//  MapShopViewController.swift
//  RabbitFlowers
//
//  Created by Иван Незговоров on 19.05.2024.
//

import UIKit
import MapKit

class MapShopViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    var pins = [PinDataStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPing()
        createMap()
    }
    
    func loadPing() {
        pins.append(PinDataStruct(adress: "​Проспект Туран, 37, цокольный этаж", loc: CLLocationCoordinate2D(latitude: 51.133506, longitude: 71.403275)))
        pins.append(PinDataStruct(adress: "Проспект Кабанбай батыр, 62", loc: CLLocationCoordinate2D(latitude: 51.089634, longitude: 71.404946)))
        pins.append(PinDataStruct(adress: "Улица Динмухамед Конаев, 12/2", loc: CLLocationCoordinate2D(latitude: 51.127396, longitude: 71.430541)))
    }
    
    func createMap() {
        let center = CLLocationCoordinate2D(latitude: 51.147692, longitude: 71.421634)
        let span = MKCoordinateSpan(latitudeDelta: 0.250, longitudeDelta: 0.250)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.region = region
        for i in pins {
            let annot = MKPointAnnotation()
            annot.title = i.adress
            annot.coordinate = i.loc
            mapView.addAnnotation(annot)
        }
        
    }
}
