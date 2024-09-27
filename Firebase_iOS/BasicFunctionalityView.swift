//
//  BasicFunctionalityView.swift
//  Firebase_iOS
//
//  Created by Robin Kirchner on 29.08.23.
//

import SwiftUI

struct BasicFunctionalityView: View {
    @EnvironmentObject var firebaseManager: FirebaseManager
    
    var body: some View {
        ZStack {
            VStack {
                firebaseManager.statusMessage()
                Button(action: firebaseManager.logBasic, label: {
                    return HStack {
                        Image(systemName: "paperplane")
                            //.imageScale(.large)
                        Text("Log Basic")
                    }
                })
                .padding()
                
                Button(action: firebaseManager.logExtended, label: {
                    return HStack {
                        Image(systemName: "paperplane.fill")
                            //.imageScale(.large)
                        Text("Log Extended")
                    }
                })
                .padding()
                
                Button(action: firebaseManager.logRandomNumber, label: {
                    return HStack {
                        Image(systemName: "paperplane.fill")
                        Text(verbatim: "Log Number \(firebaseManager.randomNumber)")
                    }
                })
                .padding()
            }
        }
        .onAppear {
            print("BasicFunctionalityView.onAppear")
        }
    }
}

struct BasicFunctionalityView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a preview with a FirebaseManager instance
        let firebaseManager = FirebaseManager()
        
        // Wrap the StartView in a NavigationView to match your app's structure
        NavigationView {
            BasicFunctionalityView()
                .environmentObject(firebaseManager)
        }
    }
}
