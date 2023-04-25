//
//  SearchResultsView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI

// View that shows search results
struct SearchResultsView: View {
	
	// ViewModel for SearchResults
	@StateObject var searchResultsViewModel: SearchResultViewModel = SearchResultViewModel()
	// the keyword being used for searching
	@State var keyword: String = ""
	
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
			.onAppear {
				searchResultsViewModel.search(keyword: keyword)
		}
			.navigationTitle("Search Results")
		}
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView()
    }
}
