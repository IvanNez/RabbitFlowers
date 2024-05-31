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
    var pins: [PinDataStruct]?
    
    var center: CLLocationCoordinate2D?
    var span: MKCoordinateSpan?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createMap()
    }
    
    func createMap() {
        guard let center else { return }
        guard let span else { return }
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.region = region
        guard let pins else { return }
        for i in pins {
            let annot = MKPointAnnotation()
            annot.title = i.adress
            annot.coordinate = i.loc
            mapView.addAnnotation(annot)
        }
        
    }
}
