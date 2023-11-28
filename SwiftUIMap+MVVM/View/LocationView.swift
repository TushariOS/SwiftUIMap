//
//  LocationView.swift
//  SwiftUIMap+MVVM
//
//  Created by Tushar Jaunjalkar on 24/11/23.
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @EnvironmentObject var viewModel: LocationViewModel
    @State private var mapre: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 2.10, longitude: 0.131),
                                                                      span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    var body: some View {
        ZStack {
            mapLayer
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                header
                    .padding()
                Spacer()
                locationPreviewStack
            }
           // .padding()
            //.frame(maxWidth: .infinity, alignment: .center)
            } .sheet(item: $viewModel.sheetLocation, onDismiss: nil) { location in
                LocationDetailView(location: location)
        }
        
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(LocationViewModel())
    }
}

extension LocationView {
    private var header: some View {
        Button {
            viewModel.toggleLocationList()
        } label: {
            VStack {
                Text(viewModel.mapLocation.name + ", " + viewModel.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: viewModel.mapLocation)
                    .background(Color.clear)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees:  viewModel.showLocationList ? 180: 0))
                    }
                
                if viewModel.showLocationList {
                    LocationListView()
                }
            }
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $viewModel.mapRegion,
            annotationItems: viewModel.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                MapAnnotationView()
                    .scaleEffect(viewModel.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        viewModel.selectedLocation(location: location)
                    }
            }
        })
    }
    
    private var locationPreviewStack: some View {
        ZStack {
            ForEach(viewModel.locations) { location in
                if viewModel.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.2), radius: 20)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
               
            }
        }
    }
}
