//
//  CalendarView.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 23/05/2023.
//

import SwiftUI
import UIKit
import FSCalendar

struct CalendarView: View {
	
	private var plantCreationDate: Date
	private var plantWateringInterval: TimeInterval
	
    var body: some View {
		CalendarViewRepresentable(plantCreationDate: plantCreationDate, plantWateringInterval: plantWateringInterval)
    }
	
	init(plantCreationDate: Date, plantWateringInterval: TimeInterval) {
		self.plantCreationDate = plantCreationDate
		self.plantWateringInterval = plantWateringInterval
	}
	
}

// UIViewRepresentable is a wrapper that allows us to integrate a UIKit View
// into a SwiftUI view hierarchy
struct CalendarViewRepresentable: UIViewRepresentable {
	
	init(plantCreationDate: Date, plantWateringInterval: TimeInterval) {
		self.plantCreationDate = plantCreationDate
		self.plantWateringInterval = plantWateringInterval
	}
	
	// typealias give a new name to an existing type
	// in this instance, UIViewType can be used everywhere as FSCalendar
	// https://www.programiz.com/swift-programming/typealias
	typealias UIViewType = FSCalendar
	
	private var plantCreationDate: Date
	private var plantWateringInterval: TimeInterval
	
	// creating an object of FSCalendar to track across the view
	fileprivate var calendar = FSCalendar()
	
	// Creates the view object and configures its initial state.
	func makeUIView(context: Context) -> FSCalendar {
		// Setting delegate and dateSource of calendar to the
		// values we get from Coordinator
		calendar.delegate = context.coordinator
		
		calendar.dataSource = context.coordinator
		
		calendar.firstWeekday = 2
		
		calendar.appearance.todayColor = .systemGreen
		calendar.appearance.titleTodayColor = .white
		
		calendar.appearance.selectionColor = .orange
		calendar.appearance.eventDefaultColor = .systemGreen
		
		calendar.appearance.titleFont = .boldSystemFont(ofSize: 24)
		calendar.appearance.titleWeekendColor = .systemGreen
		calendar.appearance.headerMinimumDissolvedAlpha = 0.12
		calendar.appearance.headerTitleFont = .systemFont(ofSize: 30, weight: .black)
		calendar.appearance.headerTitleColor = .black
		calendar.appearance.headerDateFormat = "MMMM"
		calendar.scrollDirection = .horizontal
		calendar.scope = .month
		calendar.clipsToBounds = false
		
		return calendar
	}
	
	// Used to create a custom instance that we can use to communicate between SwiftUI and UIKit views
	// Creates the custom instance that you use to communicate changes from your view to other parts of your SwiftUI interface.
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	
	// Updates the state of the specified view with new information from SwiftUI.
	func updateUIView(_ uiView: FSCalendar, context: Context) {
		//
	}
	
	
	// A type to coordinate with the view.
	class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
		
		var parent: CalendarViewRepresentable
		
		init(_ parent: CalendarViewRepresentable) {
			
			self.parent = parent
			
		}
		
		
		func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
			
			var eventDates = [Date]()
			
			for i in 0...99 {
				eventDates.append(parent.plantCreationDate.addingTimeInterval(parent.plantWateringInterval * Double(i)))
			}
			
			var eventCount = 0
			
			eventDates.forEach { eventDate in
				
				if eventDate.formatted(date: .complete, time: .omitted) == date.formatted(date: .complete, time: .omitted) {
					eventCount += 1
				}
			}
			return eventCount
		}
		
		func maximumDate(for calendar: FSCalendar) -> Date {
			Date.now.addingTimeInterval(86400*365)
		}
		
		func minimumDate(for calendar: FSCalendar) -> Date {
			Date.now.addingTimeInterval(-86400*365)
		}
		
	}
	
}

struct CalendarView_Previews: PreviewProvider {
	
    static var previews: some View {
        CalendarView(plantCreationDate: Date(), plantWateringInterval: TimeInterval(60 * 60 * 24 * 7))
    }
}
