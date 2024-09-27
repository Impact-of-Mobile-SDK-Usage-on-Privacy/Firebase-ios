//
//  ContentView.swift
//  Firebase_iOS
//
//  Created by Robin Kirchner on 28.08.23.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        ZStack {
            VStack {
                firebaseManager.statusMessage()
            }
        }
        .onAppear {
            //appData.firebaseManager.configure()
            // Additional Firebase configuration if needed
            print("ContentView.onAppear")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a preview with a FirebaseManager instance
        let firebaseManager = FirebaseManager()
        
        // Wrap the StartView in a NavigationView to match your app's structure
        NavigationView {
            ContentView()
                .environmentObject(firebaseManager)
        }
    }
}
