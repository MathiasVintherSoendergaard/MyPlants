//
//  PlantsViewModel.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 04/05/2023.
//

import Foundation
import UIKit
import SwiftUI
import CoreData

class PlantsViewModel: ObservableObject {
	
//	@Published var newPlant: Plant = Plant.samplePlant
	
	@Published var newPlantName: String = ""
	@Published var newPlantSpecies: String = ""
	@Published var newPlantDescription: String = ""
	
	@Published var newPlantSunlight: Sunlight = .notDefined
	@Published var newPlantWatering: Watering = .notDefined
	@Published var newPlantCycle: Cycle = .notDefined
	
	@Published var newPlantProfilePicture = UIImage()
	
	@Published var newPlantNotes: [String] = []
	
	@Published var newPlantImages: [Image] = []
	
	#warning("this is not neccesary")
	@Environment(\.managedObjectContext) var moc
	
	#warning("Do not remember what the idea with this was, but it ended up not getting used")
	func getNewPlant() -> Plant {
		let newPlant = Plant(
			name: newPlantName,
			species: newPlantSpecies,
			description: newPlantDescription,
			picture: Image(uiImage: newPlantProfilePicture),
			userPictures: newPlantImages,
			maintenance: Maintenance(
				watering: newPlantWatering,
				sunLight: newPlantSunlight),
			cycle: newPlantCycle,
			notes: newPlantNotes)

		return newPlant
	}
	
	func savePlant(moc: NSManagedObjectContext) {
		
		let plant = PlantEntity(context: moc)
		
		plant.id = UUID()
		plant.name = newPlantName
		plant.desc = newPlantDescription
		plant.species = newPlantSpecies
		plant.image = newPlantProfilePicture.jpegData(compressionQuality: 1)
		plant.sunlight = Int64(newPlantSunlight.rawValue)
		plant.watering = Int64(newPlantWatering.rawValue)
		plant.cycle = Int64(newPlantCycle.rawValue)
		
		try? moc.save()
		
	}
	
	func updatePlant(moc: NSManagedObjectContext) {
		
		
		
	}
}
