//
//  Application.swift
//  starter-app
//
//  Created by Bohdan Podvirnyi on 2/28/24.
//

import SwiftUI
import ReduxCore

@main
struct Application: App {
    @UIApplicationDelegateAdaptor
    private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            ApplicationView()
                
        }
    }
}

struct ApplicationView: View {
    private var store = { StoreLocator.shared }()
    
    var body: some View {
        StarterViewFactory(store: store).default()
    }
}

