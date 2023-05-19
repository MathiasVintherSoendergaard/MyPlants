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
	
//	 ManagedObjectContext which helps with Core Data
//	@Environment(\.managedObjectContext) var moc

//	 The variable that stores the fetched data from Core Data
//	@FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var plants: FetchedResults<PlantEntity>
	
	@ObservedObject var pvm = PlantsViewModel()
	
    var body: some View {
		NavigationStack {
			List {
//				ForEach(plants, id: \.self) { plant in
//					NavigationLink {
//						SinglePlantView(plant: plant)
//					} label: {
//						Text(plant.name ?? "No common name")
//					}
//				}
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
	
	init() {
		pvm.getPlants()
	}
	
}

struct AllPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        AllPlantsView()
    }
}
