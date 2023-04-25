//
//  Watering.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 19/04/2023.
//

import Foundation

// protocol CaseIterable and Identifiable used so we can
// iterate - specifically in the Pickers in AddPlantView
enum Watering: Int, CaseIterable, Identifiable {
	
	// integer values added to store in Core Data
	case none = 0, minimum = 1, average = 2, frequent = 3, notDefined = 4
	
	// Enum by itself conforms to Hashable, which is why
	// we can use Self as an identifier, as wanted by Identifiable
	var id: Self { self }
}

// extension for better code readability
extension Watering: CustomStringConvertible {
	
	var description: String {
		switch self {
		case .average: return "Average"
		case .frequent: return "Frequent"
		case .minimum: return "Minimum"
		case .none: return "None"
		case .notDefined: return "Not defined"
		}
	}
	
}

extension Watering {
	
	// init? = failable initializer - it returns an optional, which either contains a Sunlight instance or nil
	
	init?(rawValue: Int) {
		switch rawValue {
		case 0: self = .none
		case 1: self = .minimum
		case 2: self = .average
		case 3: self = .frequent
		case 4: self = .notDefined
		default: self = .notDefined
		}
	}
	
}
