//
//  AddPlantView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI

// This view lets a user add a Plant to the database
struct AddPlantView: View {
	
	@State private var name: String
	@State private var species: String
	@State private var description: String
	@State private var picture: Image
	@State private var userPictures: [Image]
	@State private var maintenance: Maintenance
	@State private var cycle: Cycle
	
	@State private var newImage = UIImage()
	
	@State private var showSheet = false
	@State private var sourceType: UIImagePickerController.SourceType = .camera
	
	private var notes: [String]
	
	#warning("change comment")
	// This is the ManagedObjectContext which does something with Core Data
	@Environment(\.managedObjectContext) var moc
	
	var body: some View {
		VStack {
			Form {
				Section {
					HStack {
						Spacer()
						Image(uiImage: self.newImage)
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
					TextField("Write the name of your plant", text: $name)
					TextField("Write the species of your plant", text: $species)
					TextField("Write a short description of your plant", text: $description)
				}
				Section {
					Picker("Watering frequency", selection: $maintenance.watering) {
						ForEach(Watering.allCases) { frequency in
							Text(frequency.description)
						}
					}
					.pickerStyle(.menu)
					
					Picker("Sunlight level", selection: $maintenance.sunLight) {
						ForEach(Sunlight.allCases) { level in
							Text(level.description)
						}
					}
					.pickerStyle(.menu)
					
					Picker("Cycle", selection: $cycle) {
						ForEach(Cycle.allCases) { cycle in
							Text(cycle.description)
						}
					}
					.pickerStyle(.menu)
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
					let plant = PlantEntity(context: moc)
					
					plant.name = name
					plant.desc = description
					plant.species = species
					plant.image = newImage.jpegData(compressionQuality: 1)
					plant.sunlight = Int64(maintenance.sunLight.rawValue)
					plant.watering = Int64(maintenance.sunLight.rawValue)
				
					try? moc.save()
					
					
				}, label: {
					HStack {
						Spacer()
						Text("Save plant")
							.bold()
						Spacer()
					}
				})
			}
				.sheet(isPresented: $showSheet) {
					ImagePicker(sourceType: self.sourceType, selectedImage: self.$newImage)
				}
			
			
		}
		
	}
	

	
	// Constructor used for preview (see bottom of this file), and for NavigationLink from SearchResultsView to this View
	init(plant: Plant) {
		self.name = plant.name
		self.species = plant.species
		self.description = plant.description
		self.picture = plant.profilePicture
		self.userPictures = plant.userPictures
		self.maintenance = plant.maintenance
		self.cycle = plant.cycle
		self.notes = plant.notes
	}
	// Used for creating an empty AddPlantView when a user adds a plant without the help of data from the API
	init() {
		self.name = ""
		self.species = ""
		self.description = ""
		self.picture = Image(systemName: "tree")
		self.userPictures = []
		self.maintenance = Maintenance(watering: .notDefined, sunLight: .notDefined)
		self.cycle = Cycle.notDefined
		self.notes = []
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

struct AddPlantView_Previews: PreviewProvider {
    static var previews: some View {
		AddPlantView(plant: Plant.samplePlant)
    }
}
