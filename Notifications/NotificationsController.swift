//
//  NotificationsController.swift
//  MyPlants
//
//  Created by Mathias Vinther Søndergaard on 26/04/2023.
//

import Foundation
import UserNotifications

class NotificationsController {
	
	func scheduleNotification(plantName: String, watering: Watering) {
		
		
		
		let center = UNUserNotificationCenter.current()
		
		let addRequest = {
			
			let content = UNMutableNotificationContent()
			
			content.title = "Plant needs watering"
			content.body = "\(plantName) needs watering"
			
			var dateComponents = DateComponents()
			
// 			To my knowledge, this should make a notification that recurs on at 9 a.m. every week on the day it was made
			dateComponents.hour = 9
			dateComponents.weekday = Calendar.current.component(.weekday, from: Date())
			let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
			
//			dateComponents.hour = 9
//			let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
			
// 			trigger for testing (i.e., it triggers a notification five seconds from now)
//			let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
			
			let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
			center.add(request)
			
		}
		
		center.getNotificationSettings { settings in
			
			if settings.authorizationStatus == .authorized {
				addRequest()
			} else {
				center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
					if success {
						addRequest()
					} else {
						print("Not authorized")
					}
				}
			}
			
		}
		
	}
}
