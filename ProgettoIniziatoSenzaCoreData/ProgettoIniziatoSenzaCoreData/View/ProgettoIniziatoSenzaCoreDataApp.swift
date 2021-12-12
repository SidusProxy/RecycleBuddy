//
//  ProgettoIniziatoSenzaCoreDataApp.swift
//  ProgettoIniziatoSenzaCoreData
//
//  Created by Gianluca Annina on 15/11/21.
//

import SwiftUI

@main
struct ProgettoIniziatoSenzaCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            if !UserDefaults.standard.bool(forKey: "LaunchBefore") {
                OnboardingView().environment(\.managedObjectContext, persistenceController.container.viewContext)

            }else{
                HomeView().environment(\.managedObjectContext, persistenceController.container.viewContext)

            }
            
        }
    }
}
