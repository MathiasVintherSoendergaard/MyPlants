//
//  AllPlantsView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 19/04/2023.
//

import SwiftUI
	

// View for showing all of a user's Plants
struct AllPlantsView: View {
	
	#warning("When implementing deletion, look at an empty Core Data project for inspiration")
	
	// ManagedObjectContext which helps with Core Data
	@Environment(\.managedObjectContext) var moc
	
	// The variable that stores the fetched data from Core Data
	@FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var plants: FetchedResults<PlantEntity>
	
    var body: some View {
		NavigationStack {
			List {
				ForEach(plants, id: \.self) { plant in
					NavigationLink {
						SinglePlantView(plant: plant)
					} label: {
						Text(plant.name ?? "No common name")
					}
				}
				.onDelete { indexSet in
					deletePlant(indexSet: indexSet)
				}
			}
		}
		.toolbar {
			EditButton()
		}
    }
	
	#warning("move this to PlantsViewModel")
	private func deletePlant(indexSet: IndexSet) {
		for index in indexSet {
			moc.delete(plants[index])
			try? moc.save()
		}
	}
	
}

struct AllPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        AllPlantsView()
    }
}
