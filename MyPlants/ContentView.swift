//
//  ContentView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
	@State private var searchText = ""

		var body: some View {
			NavigationStack {
				Spacer()
				NavigationLink {
					SearchResultsView(keyword: searchText)
				} label: {
					Text("Search plants")
				}
				Spacer()
				NavigationLink {
					AddPlantView()
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
			.searchable(text: $searchText, prompt: "Search for a plant")
			.autocorrectionDisabled(true)
		}

    

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
