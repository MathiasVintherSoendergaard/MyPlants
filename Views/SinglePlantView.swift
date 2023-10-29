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
						Button(LocalizedStringKey("showCalendarButton")) {
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
						Text(LocalizedStringKey("takeNewPictureOfPlantButton"))
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
				SinglePlantCalendarView(plantCreationDate: plant.timestampUnwrappedToDate, plantWateringInterval: Watering(rawValue: Int(plant.watering))?.timeInterval ?? TimeInterval())
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
			pvm.updatedPlantName = plant.nameUnwrapped
			pvm.updatedPlantDescription = plant.descUnwrapped
			pvm.updatedPlantSpecies = plant.speciesUnwrapped
			pvm.updatedPlantCycle = Cycle(rawValue: Int(plant.cycle))!
			pvm.updatedPlantWatering = Watering(rawValue: Int(plant.watering))!
			pvm.updatedPlantSunlight = Sunlight(rawValue: Int(plant.sunlight))!
			pvm.updatedPlantProfilePicture = UIImage(data: plant.image ?? Data()) ?? UIImage()
		}
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
				Text(LocalizedStringKey("edit"))
					.onTapGesture {
						editable.toggle()
					}
					.foregroundColor(.red)
			} else {
				Text(LocalizedStringKey("done"))
					.onTapGesture {
						editable.toggle()
						savePlant()
					}
			}
		}
		.foregroundColor(.red)
	}
	
	var headline: some View {
		Text(plant.nameUnwrapped)
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
		
		Text(String(localized: "about") + (plant.nameUnwrapped))
			.font(.title2)
	}
	
	var maintenanceSection: some View {
		
		HStack {
			DataView(name: String(localized: "cycle"), value: plant.cycleUnwrappedToString)
			DataView(name: String(localized: "watering"), value: plant.wateringUnwrappedToString)
			DataView(name: String(localized: "sunlight"), value: plant.sunlightUnwrappedToString)
			}
		
	}
	
	var infoSection: some View {
		
		VStack(alignment: .leading) {
			
			aboutPlant

			DataView(name: String(localized: "description"), value: plant.descUnwrapped)
			DataView(name: String(localized: "species"), value: plant.speciesUnwrapped)

			maintenanceSection

			DataView(name: String(localized: "plantCreationDate"), value: plant.timestampUnwrappedToString)
			
			Spacer()
		}
		
	}
}

private extension SinglePlantView {
	
	var editableInfoSection: some View {
		
		VStack(alignment: .leading) {
			
			HStack {
				Text(LocalizedStringKey("name"))
				Spacer()
				TextField(plant.nameUnwrapped, text: $pvm.updatedPlantName)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			HStack {
				Text(LocalizedStringKey("description"))
				Spacer()
				TextField(plant.descUnwrapped, text:  $pvm.updatedPlantDescription)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			HStack {
				Text(LocalizedStringKey("species"))
				Spacer()
				TextField(plant.speciesUnwrapped, text: $pvm.updatedPlantSpecies)
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
				Text(LocalizedStringKey("cycle"))
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
				Text(LocalizedStringKey("watering"))
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
				Text(LocalizedStringKey("sunlight"))
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

