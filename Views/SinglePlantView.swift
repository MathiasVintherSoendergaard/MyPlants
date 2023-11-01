//
//  SwiftUIView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI

#warning("preview does not work with PlantEntity - maybe it will work when the PlantEntity comes from pvm")

#warning("this view contains a lot of nil coalescing: 1. this solves the MVVM architecture, but more importantly, 2. I cannot currently think of a reason not to do forced unwrapping...")

struct SinglePlantView: View {
	
	@State private var editable: Bool = false
	@State var plant: PlantEntity
	
	@State private var showImageViewSheet: Bool = false
	@State private var sourceType: UIImagePickerController.SourceType = .camera
	
	@State private var showCalendarSheet: Bool = false
	
	@ObservedObject var pvm: PlantsViewModel

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
				#warning("there must be a more readable solution than this")
				SinglePlantCalendarView(plantCreationDate: pvm.singlePlant?.timestampUnwrappedToDate ?? Date(), plantWateringInterval: Watering(rawValue: pvm.singlePlant?.wateringUnwrappedToInt ?? Int())?.timeInterval ?? TimeInterval())
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
			
//			pvm.updatedPlantName = pvm.singlePlant?.nameUnwrapped ?? ""
//			pvm.updatedPlantDescription = pvm.singlePlant?.descUnwrapped ?? ""
//			pvm.updatedPlantSpecies = pvm.singlePlant?.speciesUnwrapped ?? ""
//			pvm.updatedPlantCycle = Cycle(rawValue: pvm.singlePlant?.cycleUnwrappedToInt ?? Int()) ?? .notDefined
//			pvm.updatedPlantWatering = Watering(rawValue: pvm.singlePlant?.wateringUnwrappedToInt ?? Int()) ?? .notDefined
//			pvm.updatedPlantSunlight = Sunlight(rawValue: pvm.singlePlant?.sunlightUnwrappedToInt ?? Int()) ?? .notDefined
//			pvm.updatedPlantProfilePicture = UIImage(data: pvm.singlePlant?.image ?? Data()) ?? UIImage()
		}
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
						pvm.update()
					}
			}
		}
		.foregroundColor(.red)
	}
	
	var headline: some View {
		Text(pvm.singlePlant?.nameUnwrapped ?? "")
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
		Text(String(localized: "about") + (pvm.singlePlant?.nameUnwrapped ?? ""))
			.font(.title2)
	}
	
	var maintenanceSection: some View {
		
		HStack {
			DataView(name: String(localized: "cycle"), value: pvm.singlePlant?.cycleUnwrappedToString ?? "")
			DataView(name: String(localized: "watering"), value: pvm.singlePlant?.wateringUnwrappedToString ?? "")
			DataView(name: String(localized: "sunlight"), value: pvm.singlePlant?.sunlightUnwrappedToString ?? "")
			}
		
	}
	
	var infoSection: some View {
		
		VStack(alignment: .leading) {
			
			aboutPlant

			DataView(name: String(localized: "description"), value: pvm.singlePlant?.descUnwrapped ?? "")
			DataView(name: String(localized: "species"), value: pvm.singlePlant?.speciesUnwrapped ?? "")

			maintenanceSection

			DataView(name: String(localized: "plantCreationDate"), value: pvm.singlePlant?.timestampUnwrappedToString ?? "")
			
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
				TextField(pvm.singlePlant?.nameUnwrapped ?? "", text: $pvm.updatedPlantName)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			HStack {
				Text(LocalizedStringKey("description"))
				Spacer()
				TextField(pvm.singlePlant?.descUnwrapped ?? "", text:  $pvm.updatedPlantDescription)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			HStack {
				Text(LocalizedStringKey("species"))
				Spacer()
				TextField(pvm.singlePlant?.speciesUnwrapped ?? "", text: $pvm.updatedPlantSpecies)
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

