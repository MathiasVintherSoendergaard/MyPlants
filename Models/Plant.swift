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
	
	var id: UUID
	var name: String
	var species: String
	var description: String
	var profilePicture: Image
	var userPictures: [Image]
	var maintenance: Maintenance
	var cycle: Cycle
	var notes: [String]
	
	init(name: String, species: String, description: String, picture: Image, userPictures: [Image], maintenance: Maintenance, cycle: Cycle, notes: [String]) {
		self.id = UUID()
		self.name = name
		self.species = species
		self.description = description
		self.profilePicture = picture
		self.userPictures = userPictures
		self.maintenance = maintenance
		self.cycle = cycle
		self.notes = notes
	}
	// Constructor that constructs a Plant from a PerenualPlant
	init(plant: PerenualPlant) {
		self.id = UUID()
		self.name = ""
		self.species = plant.scientificName?[0] ?? "No scientific name found"
		self.description = ""
		self.profilePicture = Image(systemName: "tree")
		self.userPictures = []
		self.maintenance = Maintenance(watering: plant.watering, sunLight: plant.sunlight)
		self.cycle = Cycle(value: plant.cycle)
		self.notes = []
	}
	#warning("This initializer is not done, but is being updated as Core Data is being updated")
	// this initializer constructs a Plant from PlantEntity, i.e., the database construct of a plant
	init(plant: PlantEntity) {
		self.id = plant.id ?? UUID()
		self.name = plant.name ?? "Something went wrong"
		self.species = plant.species ?? "Something went wrong"
		self.description = plant.desc ?? "Something went wrong"
		self.profilePicture = Image(uiImage: UIImage(data: plant.image ?? Data()) ?? UIImage())
		self.maintenance = Maintenance(watering: Watering(rawValue: Int(plant.watering))!, sunLight: Sunlight(rawValue: Int(plant.sunlight))!)
		self.cycle = Cycle(rawValue: Int(plant.cycle))!
		
		
		// properties below this comment are not yet accounted for in the database, and are thus initalized as empty
		self.userPictures = []
		self.notes = []
		
	}
	
}

// extension which houses a static instance of a Plant, used for Previews
extension Plant {
	static let samplePlant = Plant(name: "Your name for the plant", species: "The species of the plant", description: "Your description of the plant", picture: Image(systemName: "tree"), userPictures: [], maintenance: Maintenance(watering: .notDefined, sunLight: .notDefined), cycle: .notDefined, notes: [])
}
