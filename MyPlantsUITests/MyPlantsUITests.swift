//
//  MyPlantsUITests.swift
//  MyPlantsUITests
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import XCTest

final class MyPlantsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavigationToSearchResults() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
		
		// because we are dealing with a UI test, a little patience is required
		let timeout: TimeInterval = 2
		
		// we try to find the button that navigates to SearchResultsView
		let searchButton = app.otherElements.buttons["Search plants"]
		
		// we check if we have found a button
		XCTAssertTrue(searchButton.waitForExistence(timeout: timeout))
		
		// we click the button
		searchButton.tap()
		
		// we try to find a static text in the view with the value "Search Results"
		let searchResults = app.staticTexts["Search Results"]
		
		// we check if the static text actually existed
		XCTAssertTrue(searchResults.waitForExistence(timeout: timeout))
		
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
