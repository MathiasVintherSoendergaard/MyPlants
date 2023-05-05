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
			NavigationStack {
				Spacer()
				NavigationLink {
					SearchView()
				} label: {
					Text("Search plants")
				}
				Spacer()
				NavigationLink {
					AddPlantView()
						.navigationTitle("Add new plant")
				} label: {
					Text("Register new plant")
				}
				Spacer()
				NavigationLink {
					AllPlantsView()
				} label: {
					Text("See your plants")
				}
				Spacer()
			}
		}

    

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
