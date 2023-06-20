//
//  ContentView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
		var body: some View {
			TabView {
				WelcomeView()
					.tabItem {
						Label("Home", systemImage: "house")
					}
				CalendarView()
					.tabItem {
						Label("Calendar", systemImage: "calendar")
					}
				AddPlantView()
					.tabItem {
						Label("Add plant", systemImage: "plus.app")
					}
				SearchView()
					.tabItem {
						Label("Search", systemImage: "magnifyingglass")
					}
				AllPlantsView()
					.tabItem {
						Label("My Plants", systemImage: "camera.macro")
					}
			}
		}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
