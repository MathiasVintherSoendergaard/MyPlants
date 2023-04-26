//
//  Cycle.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 19/04/2023.
//

import Foundation

// protocol CaseIterable and Identifiable used so we can
// iterate - specifically in the Pickers in AddPlantView
enum Cycle: Int, CaseIterable, Identifiable {
	
	// integer values added to store in Core Data
	case perennial = 0, biennial = 1, annual = 2, biannual = 3, notDefined = 4
	
	var id: Self { self }

}
// extension for better code readability
extension Cycle: CustomStringConvertible {
	// description made so we can get a string value from the enum
	// description is also required by CustomStringConvertible
	var description: String {
		switch self {
		case .perennial: return "Perennial"
		case .biennial: return "Biennial"
		case .annual: return "Annual"
		case .biannual: return "Biannual"
		case .notDefined: return "Not defined"
		}
	}
}
// extension for better code readability
extension Cycle {
	// initializer for making a Cycle from a PerenualPlant's cycle
	init(value: String?) {
		switch value?.lowercased() {
		case "perennial":
			self = .perennial
		case "biennial":
			self = .biennial
		case "annual":
			self = .annual
		case "biannual":
			self = .biannual
		default:
			self = .notDefined
		}
	}
}

extension Cycle {
	
	// init? = failable initializer - it returns an optional, which either contains a Sunlight instance or nil
	init?(rawValue: Int) {
		switch rawValue {
		case 0: self = .perennial
		case 1: self = .biennial
		case 2: self = .annual
		case 3: self = .biannual
		case 4: self = .notDefined
		default: self = .notDefined
		}
	}
}
