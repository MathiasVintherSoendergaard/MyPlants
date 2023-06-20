//
//  WelcomeView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 20/06/2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
		VStack {
			Text(LocalizedStringKey("welcomeViewNotDoneYet"))
		}
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
