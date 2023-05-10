//
//  AllPlantsView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 19/04/2023.
//

import SwiftUI

// View for showing all of a user's Plants
struct AllPlantsView: View {
	
	// ManagedObjectContext which helps with Core Data
	@Environment(\.managedObjectContext) var moc
	
	// The variable that stores the fetched data from Core Data
	@FetchRequest(sortDescriptors: []) var plants: FetchedResults<PlantEntity>
	
	#warning("When implementing deletion, look at an empty Core Data project for inspiration")
	
    var body: some View {
		NavigationView {
			List(plants) { plant in
				NavigationLink {
					SinglePlantView(plant: Plant(plant: plant))
				} label: {
					Text(plant.name ?? "No common name")
				}
			}
		}
		
    }
}

struct AllPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        AllPlantsView()
    }
}
