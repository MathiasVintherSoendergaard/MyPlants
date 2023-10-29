//
//  PlantExtensions.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 29/10/2023.
//

import Foundation

extension PlantEntity {
	
	public var descUnwrapped: String {
		desc ?? String(localized: "noDescriptionYet")
	}
	
	public var speciesUnwrapped: String {
		species ?? String(localized: "noSpeciesYet")
	}
	
	public var nameUnwrapped: String {
		name ?? String(localized: "noNameYet")
	}
	
	public var cycleUnwrappedToString: String {
		Cycle(rawValue: Int(self.cycle))?.description ?? String(localized: "noCycleYet")
	}
	
	public var sunlightUnwrappedToString: String {
		Sunlight(rawValue: Int(self.sunlight))?.description ?? String(localized: "noWateringYet")
	}
	
	public var wateringUnwrappedToString: String {
		Watering(rawValue: Int(self.watering))?.description ?? String(localized: "noSunlightYet")
	}
	
	public var cycleUnwrappedToInt: Int {
		Int(self.cycle)
	}
	
	public var sunlightUnwrappedToInt: Int {
		Int(self.sunlight)
	}
	
	public var wateringUnwrappedToInt: Int {
		Int(self.watering)
	}
	
	public var timestampUnwrappedToDate: Date {
		self.timestamp ?? Date()
	}
	
	public var timestampUnwrappedToString: String {
		self.timestamp?.formatted(date: .numeric, time: .omitted) ?? String(localized: "noplantCreationDateYet")
	}
}
