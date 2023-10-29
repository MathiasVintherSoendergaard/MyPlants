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
	
	public var cycleUnwrapped: String {
		Cycle(rawValue: Int(self.cycle))?.description ?? String(localized: "noCycleYet")
	}
}
