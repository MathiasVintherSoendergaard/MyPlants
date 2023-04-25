//
//  MyPlantsApp.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI

@main
struct MyPlantsApp: App {
    
	@StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
