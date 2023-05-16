//
//  SwiftUIView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI

struct SinglePlantView: View {
	
//	@State var plant: Plant
	
	@State var editable: Bool = false
	
	@State var plant: PlantEntity
	
	@ObservedObject var pvm = PlantsViewModel()
	
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
						}
				}
				

				
//					NavigationLink {
//						EditPlantView(plant: plant)
//					} label: {
//						Text("Edit")
//					}
			}
			
		}
		DataView(name: "Plant id", value: plant.id?.uuidString ?? "no id yet")

		
    }
}


#warning("once I changed Plant to PlantEntity, the preview stopped working")
//struct SwiftUIView_Previews: PreviewProvider {
//
//    static var previews: some View {
//		SinglePlantView(plant: PlantEntity())
//    }
//}

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
			
			TextField(plant.name ?? "No name yet", text: $pvm.newPlantName)

			TextField(plant.desc ?? "No description yet", text: $pvm.newPlantDescription)
			
			TextField(plant.species ?? "No species yet", text: $pvm.newPlantDescription)

			editableMaintenanceSection
			
			
//					List(plant.notes, id: \.self) { note in
//						Text(note)
//					}
			Spacer()
		}
	}
	
	var editableMaintenanceSection: some View {
		
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
	
}
