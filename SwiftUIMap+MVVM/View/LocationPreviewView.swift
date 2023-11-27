//
//  LocationPreviewView.swift
//  SwiftUIMap+MVVM
//
//  Created by Tushar Jaunjalkar on 25/11/23.
//

import SwiftUI

struct LocationPreviewView: View {
    @EnvironmentObject private var viewModel: LocationViewModel
    let location: Location
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                imageSetion
                titleSection
            }
            
            VStack(alignment: .leading, spacing: 8) {
                learnMoreButton
                nextButton
            }
        }
            .padding(20)
            .background (
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .offset(y: 65)
            )
            .cornerRadius(10)
        }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPreviewView(location: LocationsDataService.locations.first!)
            .padding(10)
    }
}

extension LocationPreviewView {
    private var imageSetion: some View {
        ZStack {
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(location.name)
                .font(.title2)
            Text(location.cityName)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            viewModel.sheetLocation = location
        } label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 130, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            viewModel.nextButtonAction()
        } label: {
            Text("Next")
                .font(.headline)
                .frame(width: 130, height: 35)
        }
        .buttonStyle(.bordered)
    }
    
}
