//
//  MyPlantsUITests.swift
//  MyPlantsUITests
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import XCTest

final class MyPlantsUITests: XCTestCase {

	// when dealing with UI tests it is always smart to have a little patience
	let timeout: TimeInterval = 2
	
	let newPlantText: String = "UITestPlant"
	
	
	private var app: XCUIApplication!
	
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

		app = XCUIApplication()
		
		app.launch()
		
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavigationToSearchResults() throws {
		// we try to find the button that navigates to SearchView
		let searchButton = app.otherElements.buttons["Search plants"]
		
		// we check if we have found a button
		XCTAssertTrue(searchButton.waitForExistence(timeout: timeout))
		
		// we click the button
		searchButton.tap()
		
		// we try to find a static text in the view with the value "Search Results"
		let searchResults = app.staticTexts["Search plants"]
		
		// we check if the static text actually existed
		XCTAssertTrue(searchResults.waitForExistence(timeout: timeout))
		
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

	func testTakePictureOfPlantSheet() throws {
		
		// we try to find the button that navigates to AddPlantView
		let addPlantButton = app.otherElements.buttons["Register new plant"]
		
		// we check if we have found a button
		XCTAssertTrue(addPlantButton.waitForExistence(timeout: timeout))
		
		// we click the button
		addPlantButton.tap()
		
		// we try to find the button that show the camera sheet
		let showSheet = app.staticTexts["Take a picture of your plant"]
		
		// we check if we actually found the button
		XCTAssertTrue(showSheet.waitForExistence(timeout: timeout))
		
		// we tap the button
		showSheet.tap()
		
		// we try to find the cancel button on the camera sheet
		let cancelButton = app.staticTexts["Cancel"]
		
		// we check if we succeeded in finding the cancel button
		XCTAssertTrue(cancelButton.waitForExistence(timeout: timeout))
		
		// we tap the cancel button
		cancelButton.tap()
	}
	
	func testNavigationToAllPlantsAndSinglePlantView() throws {
		
		// we try to find the button that navigates to AllPlantsView
		let seeAllPlantsButton = app.otherElements.buttons["See your plants"]
		
		// we check if we have found a button
		XCTAssertTrue(seeAllPlantsButton.waitForExistence(timeout: timeout))
		
		// we click the button
		seeAllPlantsButton.tap()
		
		// we try to find the row with the name stored in the newPlantText variable
		// this test runs after testAddPlantView() because of the alphabet
		let newPlantRow = app.otherElements.buttons[newPlantText].firstMatch
		
		// we check if we succeeded in finding the newPlantText row
		XCTAssertTrue(newPlantRow.waitForExistence(timeout: timeout))
		
		// we tap the row
		newPlantRow.tap()
		
		// we look for the "about" textfield, which tells us that we have indeed navigated to SinglePlantView
		let aboutTextField = app.staticTexts["About \(newPlantText)"]
		
		// we check if we succeeded in finding the about textfield
		XCTAssertTrue(aboutTextField.waitForExistence(timeout: timeout))
	}
	
	func testAddPlantView() throws {
		
		// we try to find the button that navigates to AddPlantView
		let registerPlantButton = app.otherElements.buttons["Register new plant"]
		
		// we check if we have found a button
		XCTAssertTrue(registerPlantButton.waitForExistence(timeout: timeout))
		
		// we click the button
		registerPlantButton.tap()

		// finding and inputting text to name of plant textfield
		let nameOfPlantTextField = app.otherElements.textFields["Write the name of your plant"]
		
		XCTAssertTrue(nameOfPlantTextField.waitForExistence(timeout: timeout))
		
		nameOfPlantTextField.tap()
		nameOfPlantTextField.typeText(newPlantText)
		
		// finding and inputting text to species of plant textfield
		let speciesOfPlantTextField = app.otherElements.textFields["Write the species of your plant"]
		
		XCTAssertTrue(speciesOfPlantTextField.waitForExistence(timeout: timeout))
		
		speciesOfPlantTextField.tap()
		speciesOfPlantTextField.typeText(newPlantText)
		
		// finding and inputting text to description of plant textfield
		let descriptionOfPlantTextField = app.otherElements.textFields["Write a short description of your plant"]
		
		XCTAssertTrue(descriptionOfPlantTextField.waitForExistence(timeout: timeout))
		
		descriptionOfPlantTextField.tap()
		descriptionOfPlantTextField.typeText(newPlantText)

		// this last line hides the software keyboard
		descriptionOfPlantTextField.typeText("\n")
		
		// getting and setting pickers
		
		// print a debugdescription, which among other things contains view hierarchy with descriptions
		// this helped a LOT with which categories to look for UI elements (Other, Buttons, TextFields etc.)
		print(app.debugDescription)
		
		// finding the watering picker
		let wateringPicker = app.buttons.matching(identifier: "Watering frequency").firstMatch
		// waiting for the watering picker to exist and checking that it does
		XCTAssertTrue(wateringPicker.waitForExistence(timeout: timeout))
		// tapping the watering picker
		wateringPicker.tap()
		// printing again to find the individual options in the picker - they turned out to be Buttons!
		print(app.debugDescription)
		// finding the "none"-button
		let noneButton = app.buttons.matching(identifier: "None").firstMatch
		// wait for the "none" button to exist and check if it does
		XCTAssertTrue(noneButton.waitForExistence(timeout: timeout))
		// tap the "none" button
		noneButton.tap()
		
		
		
		// finding the sunlight picker
		let sunlightPicker = app.buttons.matching(identifier: "Sunlight level").firstMatch
		// waiting and checking that we found the picker
		XCTAssertTrue(sunlightPicker.waitForExistence(timeout: timeout))
		// tapping the sunlight picker
		sunlightPicker.tap()
		// finding the full sun button
		let fullSunButton = app.buttons.matching(identifier: "Full sun").firstMatch
		// wait for the full sun button to exist and check if it does
		XCTAssertTrue(fullSunButton.waitForExistence(timeout: timeout))
		// tap the full sun button
		fullSunButton.tap()

		
		
		// finding the cycle picker
		let cyclePicker = app.buttons.matching(identifier: "Cycle").firstMatch
		// waiting and checking that we found the picker
		XCTAssertTrue(cyclePicker.waitForExistence(timeout: timeout))
		// tapping the cycle picker
		cyclePicker.tap()
		// finding the annual button
		let annualButton = app.buttons.matching(identifier: "Annual").firstMatch
		// wait for the annual button to exist and check if it does
		XCTAssertTrue(annualButton.waitForExistence(timeout: timeout))
		// tap the full sun button
		annualButton.tap()
		
		app.swipeUp()
		
		// finding the "save plant" button
		let savePlantButton = app.buttons.matching(identifier: "Save plant").firstMatch
		// waiting and checking that we found the button
		XCTAssertTrue(savePlantButton.waitForExistence(timeout: timeout))
		// tapping the save plant button
		savePlantButton.tap()
		
	}
	
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIElement{
	
	func selectPicker(value: String, timeout: TimeInterval) {
		let pickerWheel = pickerWheels.firstMatch
		let row = pickerWheels[value]
		
		while !row.waitForExistence(timeout: timeout) {
			pickerWheel.adjust(toPickerWheelValue: value)
		}
	}
}
