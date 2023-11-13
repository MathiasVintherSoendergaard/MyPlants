//
//  SinglePerenualPlantRow.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 20/06/2023.
//

import SwiftUI

struct SinglePerenualPlantRow: View {
	
	let plant: PlantAPIData
	
	var body: some View {
		HStack {
			
			AsyncImage(
				url: URL(string: plant.defaultImage?.thumbnail ?? ""),
				content: { image in
					image.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(maxWidth: 40, maxHeight: 60, alignment: .leading)
				},
				placeholder: {
					ProgressView()
				})
			
			Text(plant.commonName ?? "No name")
				.frame(alignment: .leading)
		}
	}
}


