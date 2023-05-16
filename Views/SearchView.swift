//
//  SearchResultsView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI

// View that shows search results
struct SearchView: View {
	
	// ViewModel for SearchResults
	@StateObject var srvm: SearchResultViewModel = SearchResultViewModel()

	#warning("put this into viewmodel?")
	@State private var searchText = ""
	
	#warning("If a @StateObject needs to be passed around, i.e. into a subview, use @ObservedObject")
	// above warning comes from https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-observedobject-to-manage-state-from-external-objects
	
    var body: some View {
		// I saw somewhere that because of backwards compatibility
		// it is safest to use NavigationView, but Stack yields a nicer view
		NavigationStack {
			List {
				ForEach(srvm.searchResultAsPerenualPlants) { plant in
					NavigationLink {
						AddPlantView(plant: Plant(plant: plant))
					} label: {
						Text(plant.commonName ?? "No common name")
					}
				}
			}
			.navigationTitle("Search plants")
			.searchable(text: $searchText, prompt: "Search for a plant")
		}
		.onAppear {
			srvm.search(keyword: searchText)
		}
		.onChange(of: searchText) { newValue in
			srvm.search(keyword: newValue)
		}
		.textInputAutocapitalization(.never)
		.autocorrectionDisabled(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
