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
						Label(LocalizedStringKey("home"), systemImage: "house")
					}
				CalendarView()
					.tabItem {
						Label(LocalizedStringKey("calendar"), systemImage: "calendar")
					}
				AddPlantView()
					.tabItem {
						Label(LocalizedStringKey("addPlant"), systemImage: "plus.app")
					}
					.accessibilityIdentifier("Register new plant")
				SearchView()
					.tabItem {
						Label(LocalizedStringKey("search"), systemImage: "magnifyingglass")
					}
				AllPlantsView()
					.tabItem {
						Label(LocalizedStringKey("myPlants"), systemImage: "camera.macro")
					}
			}
		}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
