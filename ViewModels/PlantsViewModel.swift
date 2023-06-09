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
		
		save()
		
	}
	
	func getPlants() {
		
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
			
			save()
		}
	}
	
	func save() {
		
		do {
			try viewContext.save()
			getPlants()
		} catch {
			print("Error saving")
		}
	}
	init() {
		getPlants()
	}
}
