//
//  SwiftUIView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI

#warning("preview does not work with PlantEntity - maybe it will work when the PlantEntity comes from pvm")

struct SinglePlantView: View {
	
//	@State var plant: Plant
	
	@State var editable: Bool = false
	
	@State var plant: PlantEntity
	
	@State var updatedName: String = ""
	@State var updatedSpecies: String = ""
	@State var updatedDescription: String = ""
	
	@State var updatedCycle: Cycle = .notDefined
	@State var updatedWatering: Watering = .notDefined
	@State var updatedSunlight: Sunlight = .notDefined
	
	@State var updatedPlantProfilePicture = UIImage()
	
	@ObservedObject var pvm = PlantsViewModel()

	@State private var showSheet: Bool = false
	@State private var sourceType: UIImagePickerController.SourceType = .camera
	
    var body: some View {
		NavigationView {
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
					Spacer()
				}
	//			.navigationTitle(plant.name)
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
							showSheet = true
						}
						.foregroundColor(.blue)
					
				
					
					Spacer()
				}
				
			}
		}
		.toolbar {
			ToolbarItem() {
				
				if !editable {
					Text("Edit")
						.onTapGesture {
							editable.toggle()
						}
				} else {
					Text("Done")
						.onTapGesture {
							editable.toggle()
							savePlant()
						}
				}
				

				
//					NavigationLink {
//						EditPlantView(plant: plant)
//					} label: {
//						Text("Edit")
//					}
			}
			
		}
		.sheet(isPresented: $showSheet) {
			ImagePicker(sourceType: self.sourceType, selectedImage: $updatedPlantProfilePicture)
		}
		.onAppear {
			self.updatedName = plant.name!
			self.updatedSpecies = plant.species!
			self.updatedDescription = plant.desc!
			
			self.updatedCycle = Cycle(rawValue: Int(plant.cycle))!
			self.updatedWatering = Watering(rawValue: Int(plant.cycle))!
			self.updatedSunlight = Sunlight(rawValue: Int(plant.cycle))!
		}
		DataView(name: "Plant id", value: plant.id?.uuidString ?? "no id yet")

		
    }
	
	private func savePlant() {
		
		plant.name = updatedName
		plant.desc = updatedDescription
		plant.species = updatedSpecies
		
		plant.cycle = Int64(updatedCycle.rawValue)
		plant.watering = Int64(updatedWatering.rawValue)
		plant.sunlight = Int64(updatedSunlight.rawValue)
		
		plant.image = updatedPlantProfilePicture.jpegData(compressionQuality: 1)
		
		pvm.save()
	}
		
}

private extension SinglePlantView {
	
	var headline: some View {
		
		Text(plant.name ?? "No name yet")
			.font(.title)
		
	}
	
	var pictureSection: some View {
		HStack {
			Spacer()

			Image(uiImage: UIImage(data: plant.image ?? Data()) ?? UIImage())
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
			
			
//					List(plant.notes, id: \.self) { note in
//						Text(note)
//					}
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
				
				TextField(plant.name ?? "No name yet", text: $updatedName)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			
			HStack {
				Text("Description")
				
				Spacer()
				TextField(plant.desc ?? "No description yet", text: $updatedDescription)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			
			HStack {
				Text("Species")
				
				Spacer()
				TextField(plant.species ?? "No species yet", text: $updatedSpecies)
					.font(.subheadline)
					.foregroundColor(.secondary)
			}
			
			
			
			
			editableMaintenanceSection
			
			
			//					List(plant.notes, id: \.self) { note in
			//						Text(note)
			//					}
						Spacer()
					}
			
		}
		
	
		
	var editableMaintenanceSection: some View {
		
		Section {
			Picker("Watering frequency", selection: $updatedWatering) {
				ForEach(Watering.allCases) { frequency in
					Text(frequency.description)
				}
			}
			.pickerStyle(.menu)
			// accessibilityIdentifier added for testing purposes
			.accessibilityIdentifier("Watering frequency")
			
			Picker("Sunlight level", selection: $updatedSunlight) {
				ForEach(Sunlight.allCases) { level in
					Text(level.description)
				}
			}
			.pickerStyle(.menu)
			// accessibilityIdentifier added for testing purposes
			.accessibilityIdentifier("Sunlight level")
			
			Picker("Cycle", selection: $updatedCycle) {
				ForEach(Cycle.allCases) { cycle in
					Text(cycle.description)
				}
			}
			.pickerStyle(.menu)
			.accessibilityIdentifier("Cycle")
		}
		
	}
	
}

