//
//  DataController.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 19/04/2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
	
	static let shared = DataController()
	
	let container = NSPersistentContainer(name: "MyPlants")
	
	init() {
		container.loadPersistentStores { description, error in
			if let error = error {
				print("Core Data failed to load: \(error.localizedDescription)")
			}
		}
	}
}
