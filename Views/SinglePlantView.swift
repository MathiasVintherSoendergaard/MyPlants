//
//  SwiftUIView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI

#warning("preview does not work with PlantEntity - maybe it will work when the PlantEntity comes from pvm")

struct SinglePlantView: View {
	
	@State private var editable: Bool = false
	@State var plant: PlantEntity
	
	@State private var showImageViewSheet: Bool = false
	@State private var sourceType: UIImagePickerController.SourceType = .camera
	
	@State private var showCalendarSheet: Bool = false
	
	@ObservedObject var pvm = PlantsViewModel()

    var body: some View {
		NavigationView {
			Group {
				if !editable {
					ScrollView {
						VStack(alignment: .center) {
							headline
							Spacer()
							pictureSection
						}
						.padding()
						Divider()
						infoSection
							.padding()
						Button("show calendar") {
							showCalendarSheet.toggle()
						}
						Spacer()
					}
					.navigationBarTitleDisplayMode(.inline)
				} else {
					ScrollView {
						VStack(alignment: .center) {
							headline
							Spacer()
							pictureSection
						}
						.padding()
						Divider()
						editableInfoSection
							.padding()
						Text("Take a new picture of your plant")
							.onTapGesture {
								sourceType = .camera
								showImageViewSheet = true
							}
							.foregroundColor(.blue)
						Spacer()
					}
				}
			}
			.sheet(isPresented: $showCalendarSheet) {
				CalendarView(plantCreationDate: plant.timestamp ?? Date(), plantWateringInterval: Watering(rawValue: Int(plant.watering))?.timeInterval ?? TimeInterval())
			}
		}
		.toolbar {
			ToolbarItem() {
				editAndDoneButtons
			}
		}
		.sheet(isPresented: $showImageViewSheet) {
			CameraView(sourceType: self.sourceType, selectedImage: $pvm.updatedPlantProfilePicture)
		}
		.onAppear {
			pvm.updatedPlantName = plant.name!
			pvm.updatedPlantDescription = plant.desc!
			pvm.updatedPlantSpecies = plant.species!
			pvm.updatedPlantCycle = Cycle(rawValue: Int(plant.cycle))!
			pvm.updatedPlantWatering = Watering(rawValue: Int(plant.cycle))!
			pvm.updatedPlantSunlight = Sunlight(rawValue: Int(plant.cycle))!
			pvm.updatedPlantProfilePicture = UIImage(data: plant.image ?? Data()) ?? UIImage()
		}
		DataView(name: "Plant timestamp", value: plant.timestamp?.description ?? "no timestamp yet")
    }
	
	private func savePlant() {
		plant.name = pvm.updatedPlantName
		plant.desc = pvm.updatedPlantDescription
		plant.species = pvm.updatedPlantSpecies
		plant.cycle = Int64(pvm.updatedPlantCycle.rawValue)
		plant.watering = Int64(pvm.updatedPlantWatering.rawValue)
		plant.sunlight = Int64(pvm.updatedPlantSunlight.rawValue)
		plant.image = pvm.updatedPlantProfilePicture.jpegData(compressionQuality: 1)

		pvm.save()
	}
		
}

private extension SinglePlantView {
	
	var editAndDoneButtons: some View {
		Group {
			if !editable {
				Text("Edit")
					.onTapGesture {
						editable.toggle()
					}
					.foregroundColor(.red)
			} else {
				Text("Done")
					.onTapGesture {
						editable.toggle()
						savePlant()
					}
			}
		}
	}
	
	var headline: some View {
		Text(plant.name ?? "No name yet")
			.font(.title)
	}
	
	var pictureSection: some View {
		HStack {
			Spacer()
			Image(uiImage: pvm.updatedPlantProfilePicture)
					.resizable()
					.cornerRadius(50)
					.padding(.all, 4)
					.frame(width: 200, height: 200)
					.background(Color.black.opacity(0.2))
					.aspectRatio(contentMode: .fill)
					.clipShape(Circle())
					.padding(8)
			Spacer()
		}
	}
	
	var aboutPlant: some View {
		
		Text("About \(plant.name ?? "")")
			.font(.title2)
		
	}
	
	var maintenanceSection: some View {
		
		HStack {
			DataView(name: "Cycle", value: Cycle(rawValue: Int(plant.watering))?.description ?? "No cycle yet")
			DataView(name: "Watering", value: Watering(rawValue: Int(plant.watering))?.description ?? "No watering yet")
			DataView(name: "Sunlight", value: Sunlight(rawValue: Int(plant.sunlight))?.description ?? "No sunlight yet")
			}
		
	}
	
	var infoSection: some View {
		
		VStack(alignment: .leading) {
			
			aboutPlant

			DataView(name: "Description", value: plant.desc ?? "No description yet")
			DataView(name: "Species", value: plant.species ?? "No species yet")

			maintenanceSection
			
			Spacer()
		}
		
	}
}

private extension SinglePlantView {
	
	var editableInfoSection: some View {
		
		VStack(alignment: .leading) {
			
			HStack {
				Text("Name")
				Spacer()
				TextField(plant.name ?? "No name yet", text: $pvm.updatedPlantName)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			HStack {
				Text("Description")
				Spacer()
				TextField(plant.desc ?? "No description yet", text:  $pvm.updatedPlantDescription)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			HStack {
				Text("Species")
				Spacer()
				TextField(plant.species ?? "No species yet", text: $pvm.updatedPlantSpecies)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			editableMaintenanceSection
			Spacer()
		}
	}
		
	var editableMaintenanceSection: some View {
		Section {
			HStack {
				Text("Cycle")
				Spacer()
				Picker("Cycle", selection: $pvm.updatedPlantCycle) {
					ForEach(Cycle.allCases) { cycle in
						Text(cycle.description)
					}
				}
				.pickerStyle(.menu)
			.accessibilityIdentifier("Cycle")
			}
			HStack {
				Text("Watering")
				Spacer()
				Picker("Watering frequency", selection: $pvm.updatedPlantWatering) {
					ForEach(Watering.allCases) { frequency in
						Text(frequency.description)
					}
				}
				.pickerStyle(.menu)
				// accessibilityIdentifier added for testing purposes
			.accessibilityIdentifier("Watering frequency")
			}
			HStack {
				Text("Sunlight")
				Spacer()
				Picker("Sunlight level", selection: $pvm.updatedPlantSunlight) {
					ForEach(Sunlight.allCases) { level in
						Text(level.description)
					}
				}
				.pickerStyle(.menu)
				// accessibilityIdentifier added for testing purposes
			.accessibilityIdentifier("Sunlight level")
			}
			

		}
		
	}
	
}

