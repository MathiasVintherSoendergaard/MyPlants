//
//  Enums.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 19/04/2023.
//

import Foundation

// protocol CaseIterable and Identifiable used so we can
// iterate - specifically in the Pickers in AddPlantView
enum Sunlight: Int, CaseIterable, Identifiable {
	
	// integer values added to store in Core Data
	case fullShade = 0, partShade = 1, sunPartShade = 2, fullSun = 3, notDefined = 4
	
	// Since an enum without associated value conforms to Hashable by default, we can use this as an ID type
	var id: Self { self }
}

// Extension to make code more readable
extension Sunlight: CustomStringConvertible {
	
	// CustomStringConvertibale needs a var description
	var description: String {
		switch self {
		case .fullShade: return "Full shade"
		case .partShade: return "Part shade"
		case .sunPartShade: return "Sun/part shade"
		case .fullSun: return "Full sun"
		case .notDefined: return "Not defined"
		}
	}
}

extension Sunlight {
	
	// init? = failable initializer - it returns an optional, which either contains a Sunlight instance or nil
	init?(rawValue: Int) {
		switch rawValue {
		case 0: self = .fullShade
		case 1: self = .partShade
		case 2: self = .sunPartShade
		case 3: self = .fullSun
		case 4: self = .notDefined
		default: self = .notDefined
		}
	}
	
}
