//
//  ViewModel.swift
//  SwiftUIMap+MVVM
//
//  Created by Tushar Jaunjalkar on 24/11/23.
//

import Foundation
import MapKit
import SwiftUI

class LocationViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location] = []
    
    // Current location map
    @Published var mapLocation: Location {
        didSet {
            self.updateMapRegion(location: mapLocation)
        }
    }
    
    // Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1,
                                   longitudeDelta: 0.1)
    
    // Show list locations
    @Published var showLocationList: Bool = false
    
    //Show location details via sheet
    @Published var sheetLocation: Location? = nil
    
    init() {
        let location = LocationsDataService.locations
        self.locations = location
        self.mapLocation = location.first!
        self.updateMapRegion(location: location.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
        mapRegion = MKCoordinateRegion(center: location.coordinates,
                                           span: mapSpan)
        }
    }
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func selectedLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonAction() {
        // get current index
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation }) else  { return }
        
        //check if current index is valid
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // next index not valid restart from start locstion
            guard let firstLocation = locations.first  else {return}
            selectedLocation(location: firstLocation)
            return
        }
        
        //next location
        let nextLocation = locations[nextIndex]
        selectedLocation(location: nextLocation)
        
    }
}
