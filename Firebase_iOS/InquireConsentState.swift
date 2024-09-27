//
//  InquireConsentState.swift
//  Firebase_iOS
//
//  Created by Robin Kirchner on 28.08.23.
//

import SwiftUI

struct InquireConsentView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        ZStack {
            VStack {
                firebaseManager.statusMessage()
                    .padding()
                Button(action: firebaseManager.giveConsent, label: {
                    return HStack {
                        Image(systemName: "checkmark.circle")
                        Text("Give consent")
                    }
                })
                .padding()
                
                Button(action: firebaseManager.enableAnalytics, label: {
                    return HStack {
                        Image(systemName: "checkmark.circle")
                        Text("Enable Analytics anyway")
                    }
                })
                .padding()
            }
        }
        .onAppear {
            print("InquireConsentView.onAppear")
        }
    }
}

struct InquireConsentView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a preview with a FirebaseManager instance
        let firebaseManager = FirebaseManager()
        
        // Wrap the StartView in a NavigationView to match your app's structure
        NavigationView {
            InquireConsentView()
                .environmentObject(firebaseManager)
        }
    }
}
