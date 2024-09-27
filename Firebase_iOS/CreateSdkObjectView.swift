//
//  InitializeSDKView.swift
//  Firebase_iOS
//
//  Created by Robin Kirchner on 29.08.23.
//

import SwiftUI

struct CreateSdkObjectView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        ZStack {
            VStack {
                firebaseManager.statusMessage()
            }
        }
        .onAppear {
            firebaseManager.createSdkObject()
            print("CreateSdkObjectView.onAppear")
        }
    }
}

struct CreateSdkObjectView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a preview with a FirebaseManager instance
        let firebaseManager = FirebaseManager()
        
        // Wrap the StartView in a NavigationView to match your app's structure
        NavigationView {
            CreateSdkObjectView()
                .environmentObject(firebaseManager)
        }
    }
}
