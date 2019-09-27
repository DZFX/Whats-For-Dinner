//
//  MapViewController.swift
//  Whats For Dinner
//
//  Created by Isaac Delgado on 9/26/19.
//  Copyright © 2019 Isaac Delgado. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: - Properties
    private var viewModel = MapViewModel()
    private var isRegionSet = false
    var canDisplayDetail = true
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMap()
    }
    
    // MARK: - Config
    private func setupMap() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(viewModel.restaurantPins)
    }
    
    func configure(restaurants: [Restaurant]) {
        viewModel.setupAnnotations(restaurants: restaurants)
    }

    // MARK: - User action
    private func openDetail(from restaurant: Restaurant) {
        guard let detailVC = RestaurantDetailViewController.instantiateFromStoryboard() as? RestaurantDetailViewController else { return }
        detailVC.setupViewModel(model: restaurant)
        detailVC.canDisplayMap = false
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "RestaurantPin") ??
            MKPinAnnotationView(annotation: annotation, reuseIdentifier: "RestaurantPin")
        
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = canDisplayDetail ? UIButton(type: .detailDisclosure) : nil
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let restaurantAnnotation = view.annotation as? RestaurantAnnotation else { return }
        openDetail(from: restaurantAnnotation.restaurant)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        guard !isRegionSet else { return }
        isRegionSet = true
        mapView.setRegion(MKCoordinateRegion(center: mapView.userLocation.coordinate,
                                             span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)),
                          animated: true)
    }
}
