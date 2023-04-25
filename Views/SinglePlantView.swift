//
//  SwiftUIView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import SwiftUI

struct SinglePlantView: View {
	
	@State var plant: Plant
	
    var body: some View {
		ScrollView {
			VStack(alignment: .center) {
				Text(plant.name)
					.font(.title)
				Spacer()
				HStack {
					Spacer()
					
					plant.profilePicture
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
			.padding()
			Divider()
			VStack(alignment: .leading) {
				Text("About \(plant.name)")
					.font(.title2)
				DataView(name: "Description", value: plant.description)
				HStack {
					DataView(name: "Cycle", value: plant.cycle.description)
					DataView(name: "Watering", value: plant.maintenance.watering.description)
					DataView(name: "Sunlight", value: plant.maintenance.sunLight.description)
					}
				List(plant.notes, id: \.self) { note in
					Text(note)
				}
				Spacer()
			}
			.padding()
			Spacer()
			Button("Take new picture") {
				
			}
			.padding()
		}
		.navigationTitle(plant.name)
		.navigationBarTitleDisplayMode(.inline)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
		SinglePlantView(plant: Plant.samplePlant)
    }
}

struct CircleImage: View {
	
	var image: Image
	
	var body: some View {
		image
			.clipShape(Circle())
			.overlay {
				Circle().stroke(.white, lineWidth: 4)
			}
			.shadow(radius: 7)
	}
}


