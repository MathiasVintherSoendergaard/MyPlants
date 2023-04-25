//
//  Maintenance.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 19/04/2023.
//

import Foundation

struct Maintenance {
	var watering: Watering
	var sunLight: Sunlight
	
	init(watering: Watering, sunLight: Sunlight) {
		self.watering = watering
		self.sunLight = sunLight
	}
}

extension Maintenance {
	
	#warning("This this is a whole mess... should probably move some of it to Watering and Sunlight, respectively")
	init(watering: String?, sunLight: [String]?) {
		switch watering?.lowercased() {
		case "frequent":
			self.watering = .frequent
		case "average":
			self.watering = .average
		case "minimum":
			self.watering = .minimum
		case "none":
			self.watering = .none
		default:
			self.watering = .notDefined
		}
		
		if sunLight != nil {
			if sunLight!.count > 0 {
				switch sunLight![0].lowercased() {
				case "full shade":
					self.sunLight = .fullShade
				case "part shade":
					self.sunLight = .partShade
				case "sun-part_shade":
					self.sunLight = .sunPartShade
				case "full sun":
					self.sunLight = .fullSun
				default:
					self.sunLight = .partShade
				}
			} else {
				self.sunLight = .notDefined
			}
		} else {
			self.sunLight = .notDefined
		}
	}
}
