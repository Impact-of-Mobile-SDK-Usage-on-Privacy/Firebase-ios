//
//  Firebase_iOSApp.swift
//  Firebase_iOS
//
//  Created by Robin Kirchner on 28.08.23.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalytics

class FirebaseManager: ObservableObject {
    @Published var isConfigured = false
    @Published var isCreated = false
    @Published var randomNumber = Int.random(in: 0..<600000)

    func createSdkObject() {
        guard !isCreated else {
            print("FirebaseApp  already created. Skipping.")
            return
        }
        print(FirebaseApp.hash())
        isCreated = true
    }
    
    func giveConsent() {
        Analytics.setConsent([
          .analyticsStorage: .granted,
          .adStorage: .granted,
          .adUserData: .granted,
          .adPersonalization: .granted,
        ])
        Analytics.setAnalyticsCollectionEnabled(true)
        print("Analytics.setAnalyticsCollectionEnabled(true)")
        print("Analytics.setConsent(<all granted>)")
    }
    
    func enableAnalytics() {
        Analytics.setAnalyticsCollectionEnabled(true)
        print("Analytics.setAnalyticsCollectionEnabled(true)")
    }
    
    func configure() {
        guard !isConfigured else {
            print("FirebaseApp is already configured. Skipping.")
            return
        }
        
        FirebaseApp.configure()
        print("FirebaseApp.configure()")
        isConfigured = true
    }
    
    func logBasic() {
        guard isConfigured else {
            print("FirebaseApp is not configured yet. Skipping.")
            return
        }
        
        print("logBasic()")
        
        // typically used to track when a user selects or interacts with content in the app
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: "log_basic_button",
          AnalyticsParameterItemName: "Log Basic Button",
          AnalyticsParameterContentType: "Button",
        ])
    }
    
    func logExtended() {
        print("logExtended()")        
        // a custom log event to log whatever I want
        Analytics.logEvent("custom_log_extended_button_clicked", parameters: [
            AnalyticsParameterItemID: "custom_log_event",
            AnalyticsParameterItemName: "Bikini Bottom",
            AnalyticsParameterContentType: "Location",
        ])
        
        Analytics.logEvent("gender", parameters: [
            AnalyticsParameterItemID: "user_gender",
            AnalyticsParameterItemName: "spongebob",
            AnalyticsParameterContentType: "Gender",
        ])
    }
    
    func logRandomNumber() {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: randomNumber,
          AnalyticsParameterItemName: "Firebase Log Random Number \(randomNumber)",
          AnalyticsParameterContentType: "Button",
        ])
        print("logged", randomNumber)
        randomNumber = Int.random(in: 0..<600000)
    }
    
    func statusMessage() -> some View {
        if isConfigured {
            return AnyView(
                HStack {
                    Image(systemName: "checkmark.circle")
                        .imageScale(.large)
                        .foregroundColor(.green)
                    Text("Firebase is configured")
                }
            )
        } else {
            return AnyView(
                HStack {
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                        .foregroundColor(.red)
                    Text("Firebase is not configured")
                }
            )
        }
    }
}

struct NamedView {
    let name: String
    let view: AnyView
}

// Firebase: Create, Init, Consent, Util
let views: [NamedView] = [
    NamedView(name: "Start", view: AnyView(ContentView())),
    NamedView(name: "Create SDK Object", view: AnyView(CreateSdkObjectView())),
    NamedView(name: "Initialize SDK", view: AnyView(InitializeSDKView())),
    NamedView(name: "Inquire Consent", view: AnyView(InquireConsentView())),
    NamedView(name: "Basic Functionality", view: AnyView(BasicFunctionalityView())),
]

@main
struct Firebase_iOSApp: App {
    @StateObject var firebaseManager = FirebaseManager()
    @State private var currentViewIndex = 0
    
    @ViewBuilder
    func debugStatusMessage() -> some View {
        #if DEBUG
            AnyView(
                HStack {
                    Image(systemName: "xmark.circle")
                        .foregroundColor(.orange)
                    Text("running in DEBUG mode.")
                }
            )
        #else
            AnyView(
                HStack {
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                    Text("running in release mode.")
                }
            )
        #endif
    }

    func advanceViewIndex() -> AnyView {
        if currentViewIndex < views.count - 1 {
            return AnyView(
                Button(action: {
                    currentViewIndex += 1
                }) {
                    Text("Go to \(views[currentViewIndex + 1].name)")
                }
                .padding()
            )
        }
        return AnyView(
            Text("Final View reached.")
                .padding()
        )
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                VStack {
                    Text("\(views[currentViewIndex].name)")
                        .font(.system(size: 40))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                    debugStatusMessage()
                        .padding()

                    // Display the current view
                    views[currentViewIndex].view
                        .environmentObject(firebaseManager)
                    Spacer()
                    // Display "Next View" button
                    advanceViewIndex()
                }
            }
            .environmentObject(firebaseManager)
        }
    }
}
