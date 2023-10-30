//
//  Plant.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import Foundation
import SwiftUI

#warning("PerenualPlant and PlantEntity should be enough - phase out Plant")

// this is the struct that models a user's houseplant
struct Plant {
	
	
	var name: String
	var species: String
	var description: String
	var profilePicture: Image
	var userPictures: [Image]
	var sunLight: Sunlight
	var watering: Watering
	var cycle: Cycle
	var notes: [String]
	
	init(name: String, species: String, description: String, picture: Image, userPictures: [Image], sunLight: Sunlight, watering: Watering, cycle: Cycle, notes: [String]) {
		
		self.name = name
		self.species = species
		self.description = description
		self.profilePicture = picture
		self.userPictures = userPictures
		self.sunLight = sunLight
		self.watering = watering
		self.cycle = cycle
		self.notes = notes
	}
	// Constructor that constructs a Plant from a PerenualPlant
	init(plant: PerenualPlant) {
		
		self.name = ""
		self.species = plant.scientificName?[0] ?? "No scientific name found"
		self.description = ""
		self.profilePicture = Image(systemName: "tree")
		self.userPictures = []
		self.sunLight = Sunlight(sunLight: plant.sunlight)
		self.watering = Watering(watering: plant.watering)
		self.cycle = Cycle(value: plant.cycle)
		self.notes = []
	}
	#warning("This initializer is not done, but is being updated as Core Data is being updated")
	// this initializer constructs a Plant from PlantEntity, i.e., the database construct of a plant
	init(plant: PlantEntity) {
		self.name = plant.nameUnwrapped
		self.species = plant.speciesUnwrapped
		self.description = plant.descUnwrapped
		self.profilePicture = Image(uiImage: UIImage(data: plant.image ?? Data()) ?? UIImage())
		self.sunLight = Sunlight(rawValue: plant.sunlightUnwrappedToInt) ?? .notDefined
		self.watering = Watering(rawValue: plant.wateringUnwrappedToInt) ?? .notDefined
		self.cycle = Cycle(rawValue: plant.cycleUnwrappedToInt)!
		
		
		// properties below this comment are not yet accounted for in the database, and are thus initalized as empty
		self.userPictures = []
		self.notes = []
		
	}
	
}

// extension which houses a static instance of a Plant, used for Previews
extension Plant {
	static let samplePlant = Plant(name: "Your name for the plant", species: "The species of the plant", description: "Your description of the plant", picture: Image(systemName: ""), userPictures: [], sunLight: .notDefined, watering: .notDefined, cycle: .notDefined, notes: [])
}
