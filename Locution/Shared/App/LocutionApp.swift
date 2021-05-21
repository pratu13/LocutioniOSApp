//
//  LocutionApp.swift
//  Shared
//
//  Created by Pratyush  on 4/13/21.
//

import SwiftUI
import CoreData

@main
struct LocutionApp: App {
    let persistanceContainer = PersistanceController.shared
    
    
    var body: some Scene {
        WindowGroup {
            LocutionList()
                .environment(\.managedObjectContext, persistanceContainer.container.viewContext)
        }
    }
}
