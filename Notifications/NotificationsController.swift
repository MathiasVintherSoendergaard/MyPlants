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
		
		switch watering {
		case .none:
			return
		case .notDefined:
			return
		case .minimum:
			scheduleMonthlyNotification(plantName: plantName)
		case .average:
			scheduleWeeklyNotification(plantName: plantName)
		case .frequent:
			scheduleTwiceWeeklyNotification(plantName: plantName)
		}
	}
	
	private func scheduleMonthlyNotification(plantName: String) {
		let center = UNUserNotificationCenter.current()
		
		let addRequest = {
			
			let content = UNMutableNotificationContent()
			
			content.title = "Plant needs watering"
			content.body = "\(plantName) needs watering"
			
			var dateComponents = DateComponents()
			
			// 9 a.m.
			dateComponents.hour = 9
			
			// .day returns an integer that represents the date, i.e. how many days we are in to a given month
			dateComponents.day = Calendar.current.component(.day, from: Date())
			
			// we check that the date is not above 28, since not all months have that many days
			if dateComponents.day! > 28 {
				dateComponents.day = 28
			}
			
			let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
			
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
	
	private func scheduleWeeklyNotification(plantName: String) {
		let center = UNUserNotificationCenter.current()
		
		let addRequest = {
			
			let content = UNMutableNotificationContent()
			
			content.title = "Plant needs watering"
			content.body = "\(plantName) needs watering"
			
			
			var dateComponents = DateComponents()
			
			// To my knowledge, this should make a notification that recurs on at 9 a.m. every week on the day it was made
			dateComponents.hour = 9
			dateComponents.weekday = Calendar.current.component(.weekday, from: Date())
			let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
			
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
	
	private func scheduleTwiceWeeklyNotification(plantName: String) {
		let center = UNUserNotificationCenter.current()
		
		let addRequest = {
			
			let content = UNMutableNotificationContent()
			
			content.title = "Plant needs watering"
			content.body = "\(plantName) needs watering"
			
			// 345.600 seconds is four days
			// this should create a trigger that repeats every four days
			// could be better though, i.e., this is just four days out from whenever a plant is
			// added, so it could be in the middle of the night
			let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 345_600, repeats: true)
			
			let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
			center.add(request)
			
			
			
		}
		
		center.getNotificationSettings { settings in
			
			if settings.authorizationStatus == .authorized {
				addRequest()
			} else {
				center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
					if success {
						self.plants.append(plantName)
						addRequest()
					} else {
						print("Not authorized")
					}
				}
			}
			
		}
	}
	
}
