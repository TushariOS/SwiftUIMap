//
//  SwiftUIMap_MVVMApp.swift
//  SwiftUIMap+MVVM
//
//  Created by Tushar Jaunjalkar on 24/11/23.
//

import SwiftUI

@main
struct SwiftUIMap_MVVMApp: App {
    
    @StateObject private var viewModel = LocationViewModel()
    
    /// App state
    @Environment (\.scenePhase) private var spacePhase
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(viewModel)
        }
        .onChange(of: spacePhase) { phase in
            switch phase {
            case .background:
                print("Background")
            case .inactive:
                print("Inactive")
            case .active:
                print("Active")
            @unknown default:
                print("Default")
            }
        }
    }
}
