//
//  AllPlantsView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 19/04/2023.
//

import SwiftUI
	

// View for showing all of a user's Plants
struct AllPlantsView: View {
	
	@StateObject var pvm = PlantsViewModel()
	
    var body: some View {
		NavigationStack {
			List {
				ForEach(pvm.plants, id: \.id) { plant in
					NavigationLink {
						SinglePlantView(plant: plant)
					} label: {
						Text(plant.name ?? "No name")
					}
				}
				.onDelete { indexSet in
					pvm.deletePlant(indexSet: indexSet)
				}
			}
		}
		.toolbar {
			EditButton()
		}
    }
	
	init() {}
	
}

struct AllPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        AllPlantsView()
    }
}
