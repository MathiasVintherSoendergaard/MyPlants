//
//  AddPlantView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI

// This view lets a user add a Plant to the database
struct AddPlantView: View {
	
	@State private var showSheet: Bool = false
	@State private var sourceType: UIImagePickerController.SourceType = .camera
	
	private var notificationsController = NotificationsController()
	
	@ObservedObject private var pvm = PlantsViewModel()
	
	var body: some View {
		VStack {
			NavigationStack {
				Form {
					pictureSection
					Section {
						TextField("Write the name of your plant", text: $pvm.newPlantName)
						TextField("Write the species of your plant", text: $pvm.newPlantSpecies)
						TextField("Write a short description of your plant", text: $pvm.newPlantDescription)
					}
					pickerSection
					addImageSection
					savePlantButton
				}
				.sheet(isPresented: $showSheet) {
					ImagePicker(sourceType: self.sourceType, selectedImage: $pvm.newPlantProfilePicture)
				}
			}
		}
	}
	
	private func savePlant() {
		
		pvm.addPlant()
		
		notificationsController.scheduleNotification(plantName: pvm.newPlantName, watering: pvm.newPlantWatering)
	}
	
	// Constructor used for preview (see bottom of this file), and for NavigationLink from SearchResultsView to this View
	init(plant: Plant) {
		
		pvm.newPlantName = plant.name
		pvm.newPlantSpecies = plant.species
		pvm.newPlantDescription = plant.description
		pvm.newPlantProfilePicture = UIImage()
		pvm.newPlantImages = plant.userPictures
		pvm.newPlantSunlight = plant.maintenance.sunLight
		pvm.newPlantWatering = plant.maintenance.watering
		pvm.newPlantCycle = plant.cycle
		pvm.newPlantNotes = plant.notes
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
	
}

private extension AddPlantView {
	
	var pictureSection: some View {
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
	}
	
	var pickerSection: some View {
		
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
	}
	
	var addImageSection: some View {
		Section {
			Text("Take a picture of your plant")
				.onTapGesture {
					sourceType = .camera
					showSheet = true
				}
				.foregroundColor(.blue)
			// for some reason, the button under here does not work, unless you push the above button first
			// what is currently on line 88 simply does not add new value to sourceType
			Text("Choose a picture of your plant")
				.onTapGesture {
					sourceType = .photoLibrary
					showSheet = true
				}
				.foregroundColor(.blue)
		}
	}
	
	var savePlantButton: some View {
		Button(action:
				{
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
	

	
}

struct AddPlantView_Previews: PreviewProvider {
    static var previews: some View {
		AddPlantView(plant: Plant.samplePlant)
    }
}
