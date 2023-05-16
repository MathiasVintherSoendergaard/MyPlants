//
//  EditPlantView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 15/05/2023.
//

import SwiftUI

struct EditPlantView: View {
	
	@State var plant: Plant
	
	@ObservedObject private var pvm = PlantsViewModel()
	
	@State private var showSheet = false
	@State private var sourceType: UIImagePickerController.SourceType = .camera
	
	var body: some View {
		VStack {
			NavigationStack {
				Form {
					pictureSection
					Section {
						TextField(plant.name, text: $pvm.newPlantName)
						TextField(plant.species, text: $pvm.newPlantSpecies)
						TextField(plant.description, text: $pvm.newPlantDescription)
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
}

struct EditPlantView_Previews: PreviewProvider {
    static var previews: some View {
        EditPlantView(plant: Plant.samplePlant)
    }
}

private extension EditPlantView {
	
	var pictureSection: some View {
		Section {
			HStack {
				Spacer()
				plant.profilePicture
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
			Picker("Watering frequency", selection: $plant.maintenance.watering) {
				ForEach(Watering.allCases) { frequency in
					Text(frequency.description)
				}
			}
			.pickerStyle(.menu)
			// accessibilityIdentifier added for testing purposes
			.accessibilityIdentifier("Watering frequency")

			Picker("Sunlight level", selection: $plant.maintenance.sunLight) {
				ForEach(Sunlight.allCases) { level in
					Text(level.description)
				}
			}
			.pickerStyle(.menu)
			// accessibilityIdentifier added for testing purposes
			.accessibilityIdentifier("Sunlight level")
			
			Picker("Cycle", selection: $plant.cycle) {
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
			updatePlant()
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
	
	private func updatePlant() {
		plant.name = pvm.newPlantName
		plant.description
	}
	
}
