//
//  SinglePlantRow.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 20/06/2023.
//

import SwiftUI

struct SinglePlantRow: View {
	
	let plant: PlantEntity
	
    var body: some View {
		HStack {
			Image(uiImage: UIImage(data: plant.image!) ?? UIImage())
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(maxWidth: 40, maxHeight: 60, alignment: .leading)
			Text(plant.name ?? "No name")
				.frame(alignment: .leading)
		}
    }
}

