//
//  PlantsViewModel.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import Foundation

#warning("Refactoring to be done")
// i.e., should there be a repository-class?
// this will take a whole other approach to making and API call
// it will require return values, which is not possible to do with the way
// func search() is built right now

// ViewModel to contain and publish SearchResults
class SearchResultsViewModel: ObservableObject {
	@Published var searchResultAsPerenualPlants: [PerenualPlant] = []
	private let baseURL: String = "https://perenual.com/api/species-list?key=sk-rcKX642a8418ba664419&q="
	func search(keyword: String) {
		guard let url = URL(string: baseURL + keyword) else { fatalError("Missing URL")}
		let urlRequest = URLRequest(url: url)
		let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
			if let error = error {
				print("Request error: ", error)
				return
			}
			guard let response = response as? HTTPURLResponse else { return }
			if response.statusCode == 200 {
				guard let data = data else { return }
				DispatchQueue.main.async {
					do {
						let decodedData = try JSONDecoder().decode(SearchResult.self, from: data)
						self.searchResultAsPerenualPlants = decodedData.data ?? []
						print(self.searchResultAsPerenualPlants)
					} catch let error {
						print("Error decoding: ", error)
					}
				}
			}
		}
		dataTask.resume()
	}
}
