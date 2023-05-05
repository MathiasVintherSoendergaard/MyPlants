//
//  AddPlantView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI

// This view lets a user add a Plant to the database
struct AddPlantView: View {
	
	@ObservedObject private var pvm = PlantsViewModel()
	@State private var showSheet = false
	@State private var sourceType: UIImagePickerController.SourceType = .camera
	
	#warning("change comment")
	// This is the ManagedObjectContext which does something with Core Data
	@Environment(\.managedObjectContext) var moc
	
	private var notificationsController = NotificationsController()
	
	var body: some View {
		VStack {
			NavigationStack {
				Form {
					Section {
						HStack {
							Spacer()
							Image(uiImage: pvm.newPlantProfilePicture)
								.resizable()
								.cornerRadius(50)
								.padding(.all, 4)
								.frame(width: 200, height: 200, alignment: .center)
								.background(Color.red.opacity(0.2))
								.aspectRatio(contentMode: .fill)
								.clipShape(Circle())
								.padding()
							Spacer()
						}
					}
					Section {
						TextField("Write the name of your plant", text: $pvm.newPlantName)
						TextField("Write the species of your plant", text: $pvm.newPlantSpecies)
						TextField("Write a short description of your plant", text: $pvm.newPlantDescription)
					}
					Section {
						Picker("Watering frequency", selection: $pvm.newPlantWatering) {
							ForEach(Watering.allCases) { frequency in
								Text(frequency.description)
							}
						}
						.pickerStyle(.menu)
						// accessibilityIdentifier added for testing purposes
						.accessibilityIdentifier("Watering frequency")

						Picker("Sunlight level", selection: $pvm.newPlantSunlight) {
							ForEach(Sunlight.allCases) { level in
								Text(level.description)
							}
						}
						.pickerStyle(.menu)
						// accessibilityIdentifier added for testing purposes
						.accessibilityIdentifier("Sunlight level")
						
						Picker("Cycle", selection: $pvm.newPlantCycle) {
							ForEach(Cycle.allCases) { cycle in
								Text(cycle.description)
							}
						}
						.pickerStyle(.menu)
						.accessibilityIdentifier("Cycle")
					}
					Section {
						Text("Take a picture of your plant")
							.onTapGesture {
								sourceType = .camera
								showSheet = true
							}
						// for some reason, the button under here does not work, unless you push the above button first
						// what is currently on line 88 simply does not add new value to sourceType
						Text("Choose a picture of your plant")
							.onTapGesture {
								sourceType = .photoLibrary
								showSheet = true
							}
					}
					
					// her skal der tages imod den første note
					
					Button(action: {
						savePlant()
					}, label: {
						HStack {
							Spacer()
							Text("Save plant")
								.bold()
							Spacer()
						}
					})
					.accessibilityIdentifier("Save plant")
				}
				.sheet(isPresented: $showSheet) {
					ImagePicker(sourceType: self.sourceType, selectedImage: $pvm.newPlantProfilePicture)
			}
			}
			
			
		}
		
	}
	
	func savePlant() {
		
		pvm.savePlant(moc: moc)
		
		setUpNotifications(plantName: pvm.newPlantName, watering: pvm.newPlantWatering)
	}
	
	func setUpNotifications(plantName: String, watering: Watering) {
		
		notificationsController.scheduleNotification(plantName: plantName, watering: watering)
		
	}
	
	// Constructor used for preview (see bottom of this file), and for NavigationLink from SearchResultsView to this View
	init(plant: Plant) {
		self.pvm.newPlantName = plant.name
		self.pvm.newPlantSpecies = plant.species
		self.pvm.newPlantDescription = plant.description
		self.pvm.newPlantProfilePicture = UIImage()
		self.pvm.newPlantImages = plant.userPictures
		self.pvm.newPlantSunlight = plant.maintenance.sunLight
		self.pvm.newPlantWatering = plant.maintenance.watering
		self.pvm.newPlantCycle = plant.cycle
		self.pvm.newPlantNotes = plant.notes
	}
	// Used for creating an empty AddPlantView when a user adds a plant without the help of data from the API
	init() {
		
		self.pvm.newPlantName = ""
		self.pvm.newPlantSpecies = ""
		self.pvm.newPlantDescription = ""
		self.pvm.newPlantProfilePicture = UIImage(systemName: "tree")!
		self.pvm.newPlantImages = []
		self.pvm.newPlantSunlight = Sunlight.notDefined
		self.pvm.newPlantWatering = Watering.notDefined
		self.pvm.newPlantCycle = Cycle.notDefined
		self.pvm.newPlantNotes = []
		
	}
#warning("This constructor was not being used, so I commented it out. It may be useful later.")
//	init(name: String, species: String, description: String, picture: Image, userPictures: [Image], maintenance: Maintenance, cycle: Cycle, notes: [String]) {
//		self.name = name
//		self.species = species
//		self.description = description
//		self.picture = picture
//		self.userPictures = userPictures
//		self.maintenance = maintenance
//		self.cycle = cycle
//		self.notes = notes
//	}
}

private extension AddPlantView {
	
	
	
}


struct AddPlantView_Previews: PreviewProvider {
    static var previews: some View {
		AddPlantView(plant: Plant.samplePlant)
    }
}
