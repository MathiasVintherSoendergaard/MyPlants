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
	@StateObject var searchResultsViewModel: SearchResultViewModel = SearchResultViewModel()
	
	@State private var searchText = ""
	
    var body: some View {
		// I saw somewhere that because of backwards compatibility
		// it is safest to use NavigationView, but Stack yields a nicer view
		NavigationStack {
			List {
				ForEach(searchResultsViewModel.searchResultAsPerenualPlants) { plant in
					NavigationLink {
						AddPlantView(plant: Plant(plant: plant))
					} label: {
						Text(plant.commonName ?? "No common name")
					}
				}
			}

			.navigationTitle("Search plants")
			.searchable(text: $searchText, prompt: "Search for a plant")
			.autocorrectionDisabled(true)
			.onChange(of: searchText) { newValue in
				searchResultsViewModel.search(keyword: newValue)
			}
		}
		
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
