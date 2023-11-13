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
						TextField(LocalizedStringKey("plantName"), text: $pvm.newPlantName)
						TextField(LocalizedStringKey("plantSpecies"), text: $pvm.newPlantSpecies)
						TextField(LocalizedStringKey("plantDescription"), text: $pvm.newPlantDescription)
					}
					pickerSection
					addImageSection
					savePlantButton
				}
				.sheet(isPresented: $showSheet) {
					CameraView(sourceType: self.sourceType, selectedImage: $pvm.newPlantProfilePicture)
				}
			}
		}
	}
	
	private func savePlant() {
		
		pvm.addPlant()
		
		notificationsController.scheduleNotification(plantName: pvm.newPlantName, watering: pvm.newPlantWatering)
		
		wipeView()
		
	}
	
	// Constructor used for preview (see bottom of this file), and for NavigationLink from SearchResultsView to this View
	init(plant: Plant) {
		
		pvm.newPlantName = plant.name
		pvm.newPlantSpecies = plant.species
		pvm.newPlantDescription = plant.description
		pvm.newPlantProfilePicture = UIImage()
		pvm.newPlantImages = plant.userPictures
		pvm.newPlantSunlight = plant.sunLight
		pvm.newPlantWatering = plant.watering
		pvm.newPlantCycle = plant.cycle
		pvm.newPlantNotes = plant.notes
	}
	
	// Used for creating an empty AddPlantView when a user adds a plant without the help of data from the API
	
	init() {}
	
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
			Picker(LocalizedStringKey("watering"), selection: $pvm.newPlantWatering) {
				ForEach(Watering.allCases) { frequency in
					Text(frequency.description)
				}
			}
			.pickerStyle(.menu)
			// accessibilityIdentifier added for testing purposes
			.accessibilityIdentifier("Watering frequency")

			Picker(LocalizedStringKey("sunlight"), selection: $pvm.newPlantSunlight) {
				ForEach(Sunlight.allCases) { level in
					Text(level.description)
				}
			}
			.pickerStyle(.menu)
			// accessibilityIdentifier added for testing purposes
			.accessibilityIdentifier("Sunlight level")
			
			Picker(LocalizedStringKey("cycle"), selection: $pvm.newPlantCycle) {
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
			Text(LocalizedStringKey("takePictureButton"))
				.onTapGesture {
					sourceType = .camera
					showSheet = true
				}
				.foregroundColor(.blue)
			// for some reason, the button under here does not work, unless you push the above button first
			// what is currently on line 88 simply does not add new value to sourceType
			Text(LocalizedStringKey("choosePictureButton"))
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
				Text(LocalizedStringKey("savePlantButton"))
					.bold()
				Spacer()
			}
		})
		.accessibilityIdentifier("Save plant")
	}
	
	private func wipeView() {
		self.pvm.newPlantName = ""
		self.pvm.newPlantSpecies = ""
		self.pvm.newPlantDescription = ""
		self.pvm.newPlantProfilePicture = UIImage()
		self.pvm.newPlantImages = []
		self.pvm.newPlantSunlight = Sunlight.notDefined
		self.pvm.newPlantWatering = Watering.notDefined
		self.pvm.newPlantCycle = Cycle.notDefined
		self.pvm.newPlantNotes = []
	}
	
}

struct AddPlantView_Previews: PreviewProvider {
    static var previews: some View {
		AddPlantView(plant: Plant.samplePlant)
    }
}
