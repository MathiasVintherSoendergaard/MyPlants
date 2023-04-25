//
//  DataRow.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 19/04/2023.
//

import SwiftUI
// refactored View to hold data
struct DataView: View {
	
	var name: String
	var value: String
	
	var body: some View {
		
		VStack(alignment: .leading) {
			Text(name)
				.font(.subheadline)
				.foregroundColor(.secondary)
			Text(value)
		}
		.padding()
		
	}
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView(name: "placeholder", value: "placeholder")
    }
}
