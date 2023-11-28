//
//  LocationListView.swift
//  SwiftUIMap+MVVM
//
//  Created by Tushar Jaunjalkar on 25/11/23.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject private var viewModel:  LocationViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.locations) { location in
                // Button {
                //     viewModel.selectedLocation(location: location)
                // } label: {
                listRowView(location: location)
                    .onTapGesture {
                        viewModel.selectedLocation(location: location)
                    }
                //                }
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
            .environmentObject(LocationViewModel())
    }
}

extension LocationListView {
    private func listRowView(location: Location) -> some View {
        HStack {
            if let locationImage: String = location.imageNames.first {
                Image(locationImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                    .cornerRadius(10)
            }
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
