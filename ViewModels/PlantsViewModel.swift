//
//  PlantsViewModel.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 04/05/2023.
//

import Foundation
import SwiftUI
import CoreData

class PlantsViewModel: ObservableObject {
	
	@Published var newPlantName: String = ""
	@Published var newPlantSpecies: String = ""
	@Published var newPlantDescription: String = ""
	@Published var newPlantSunlight: Sunlight = .notDefined
	@Published var newPlantWatering: Watering = .notDefined
	@Published var newPlantCycle: Cycle = .notDefined
	@Published var newPlantProfilePicture = UIImage()
	@Published var newPlantNotes: [String] = []
	@Published var newPlantImages: [Image] = []
	
	@Published var updatedPlantName: String = ""
	@Published var updatedPlantDescription: String = ""
	@Published var updatedPlantSpecies: String = ""
	@Published var updatedPlantSunlight: Sunlight = .notDefined
	@Published var updatedPlantWatering: Watering = .notDefined
	@Published var updatedPlantCycle: Cycle = .notDefined
	@Published var updatedPlantProfilePicture: UIImage = UIImage()
	
	@Published var plants: [PlantEntity] = []
	
	@Published var singlePlant: PlantEntity?
	
	// TODO: change relationship between viewmodel and datacontroller, and injection of the latter
	private let viewContext = DataController.shared.container.viewContext
	
	func addPlant() {
		
		let newPlant = PlantEntity(context: viewContext)
		
		
		newPlant.name = newPlantName
		newPlant.desc = newPlantDescription
		newPlant.species = newPlantSpecies
		newPlant.image = newPlantProfilePicture.jpegData(compressionQuality: 1)
		newPlant.sunlight = Int64(newPlantSunlight.rawValue)
		newPlant.watering = Int64(newPlantWatering.rawValue)
		newPlant.cycle = Int64(newPlantCycle.rawValue)
		
		newPlant.timestamp = Date()
		
		saveContext()
		
	}
	
	func getAllPlants() {
		
		let request = NSFetchRequest<PlantEntity>(entityName: "PlantEntity")
		
		do {
			plants = try viewContext.fetch(request)
		} catch {
			print("DEBUG: Some error occured while fetching")
		}
		
	}
	
	func deletePlant(indexSet: IndexSet) {
		
		for index in indexSet {
			
			viewContext.delete(plants[index])
			
			saveContext()
		}
	}
	
	func updatePlant() {
		
		singlePlant?.name = updatedPlantName
		singlePlant?.desc = updatedPlantDescription
		singlePlant?.species = updatedPlantSpecies
		singlePlant?.cycle = Int64(updatedPlantCycle.rawValue)
		singlePlant?.watering = Int64(updatedPlantWatering.rawValue)
		singlePlant?.sunlight = Int64(updatedPlantSunlight.rawValue)
		singlePlant?.image = updatedPlantProfilePicture.jpegData(compressionQuality: 1)
		
		saveContext()
	}
	
	func saveContext() {
		
		do {
			try viewContext.save()
			getAllPlants()
		} catch {
			print("Error saving")
		}
	}
	init() {
		getAllPlants()
	}
}
