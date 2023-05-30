//
//  MyPlantsTests.swift
//  MyPlantsTests
//
//  Created by Mathias Vinther Søndergaard on 17/04/2023.
//

import XCTest
import UserNotifications
@testable import MyPlants

final class MyPlantsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWateringEnumeratorIntInit() throws {
        
		
		let wateringEnumMinimum = Watering(rawValue: Int.min)
		
		XCTAssertEqual(wateringEnumMinimum, Watering.notDefined)
		
		let wateringEnumMinus1 = Watering(rawValue: -1)
		
		XCTAssertEqual(wateringEnumMinus1, Watering.notDefined)
		
		let wateringEnum0 = Watering(rawValue: 0)
		
		XCTAssertEqual(wateringEnum0, Watering.none)
		
		let wateringEnum1 = Watering(rawValue: 1)
		
		XCTAssertEqual(wateringEnum1, Watering.minimum)
		
		let wateringEnum2 = Watering(rawValue: 2)
		
		XCTAssertEqual(wateringEnum2, Watering.average)
		
		let wateringEnum3 = Watering(rawValue: 3)
		
		XCTAssertEqual(wateringEnum3, Watering.frequent)
		
		let wateringEnum4 = Watering(rawValue: 4)
		
		XCTAssertEqual(wateringEnum4, Watering.notDefined)
		
		let wateringEnum5 = Watering(rawValue: 5)
		
		XCTAssertEqual(wateringEnum5, Watering.notDefined)
		
		let wateringEnumMaximum = Watering(rawValue: Int.max)
		
		XCTAssertEqual(wateringEnumMaximum, Watering.notDefined)
    }
	
	func testWateringEnumeratorDescription() throws {
		
		let wateringEnumNone = Watering(rawValue: 0)

		XCTAssertEqual(wateringEnumNone?.description, "None")
		
		let wateringEnumMinimum = Watering(rawValue: 1)

		XCTAssertEqual(wateringEnumMinimum?.description, "Minimum")
		
		let wateringEnumAverage = Watering(rawValue: 2)
		
		XCTAssertEqual(wateringEnumAverage?.description, "Average")
		
		let wateringEnumFrequent = Watering(rawValue: 3)
		
		XCTAssertEqual(wateringEnumFrequent?.description, "Frequent")
		
		let wateringEnumNotDefined = Watering(rawValue: 4)
		
		XCTAssertEqual(wateringEnumNotDefined?.description, "Not defined")
	}
	
	func testSunlightEnumeratorIntInit() throws {
		
		let sunlightEnumMinimum = Sunlight(rawValue: Int.min)
		
		XCTAssertEqual(sunlightEnumMinimum, Sunlight.notDefined)
		
		let sunlightEnumMinus1 = Sunlight(rawValue: -1)
		
		XCTAssertEqual(sunlightEnumMinus1, Sunlight.notDefined)
		
		let sunligtEnum0 = Sunlight(rawValue: 0)
		
		XCTAssertEqual(sunligtEnum0, Sunlight.fullShade)
		
		let sunlightEnum1 = Sunlight(rawValue: 1)
		
		XCTAssertEqual(sunlightEnum1, Sunlight.partShade)
		
		let sunlightEnum2 = Sunlight(rawValue: 2)
		
		XCTAssertEqual(sunlightEnum2, Sunlight.sunPartShade)
		
		let sunlightEnum3 = Sunlight(rawValue: 3)
		
		XCTAssertEqual(sunlightEnum3, Sunlight.fullSun)
		
		let sunlightEnum4 = Sunlight(rawValue: 4)
		
		XCTAssertEqual(sunlightEnum4, Sunlight.notDefined)
		
		let sunlightEnum5 = Sunlight(rawValue: 5)
		
		XCTAssertEqual(sunlightEnum5, Sunlight.notDefined)
		
		let sunlightEnumMaximum = Sunlight(rawValue: Int.max)
		
		XCTAssertEqual(sunlightEnumMaximum, Sunlight.notDefined)
	}

	func testSunlightEnumeratorDescription() throws {
		
		let sunligtEnumFullShade = Sunlight(rawValue: 0)
		
		XCTAssertEqual(sunligtEnumFullShade?.description, "Full shade")
		
		let sunlightEnumPartShade = Sunlight(rawValue: 1)
		
		XCTAssertEqual(sunlightEnumPartShade?.description, "Part shade")
		
		let sunlightEnumSunPartShade = Sunlight(rawValue: 2)
		
		XCTAssertEqual(sunlightEnumSunPartShade?.description, "Sun/part shade")
		
		let sunlightEnumFullSun = Sunlight(rawValue: 3)
		
		XCTAssertEqual(sunlightEnumFullSun?.description, "Full sun")
		
		let sunlightEnumNotDefined = Sunlight(rawValue: 4)
		
		XCTAssertEqual(sunlightEnumNotDefined?.description, "Not defined")
		
	}
	
	func testCycleEnumeratorIntInit() throws {
		
		let cycleEnumMinimum = Cycle(rawValue: Int.min)
		
		XCTAssertEqual(cycleEnumMinimum, Cycle.notDefined)
		
		let cycleEnumMinus1 = Cycle(rawValue: -1)
		
		XCTAssertEqual(cycleEnumMinus1, Cycle.notDefined)
		
		let cycleEnum0 = Cycle(rawValue: 0)
		
		XCTAssertEqual(cycleEnum0, Cycle.perennial)
		
		let cycleEnum1 = Cycle(rawValue: 1)
		
		XCTAssertEqual(cycleEnum1, Cycle.biennial)
		
		let cycleEnum2 = Cycle(rawValue: 2)
		
		XCTAssertEqual(cycleEnum2, Cycle.annual)
		
		let cycleEnum3 = Cycle(rawValue: 3)
		
		XCTAssertEqual(cycleEnum3, Cycle.biannual)
		
		let cycleEnum4 = Cycle(rawValue: 4)
		
		XCTAssertEqual(cycleEnum4, Cycle.notDefined)
		
		let cycleEnum5 = Cycle(rawValue: 5)
		
		XCTAssertEqual(cycleEnum5, Cycle.notDefined)
		
		let cycleEnumMaximum = Cycle(rawValue: Int.max)
		
		XCTAssertEqual(cycleEnumMaximum, Cycle.notDefined)
		
	}
	
	func testCycleEnumeratorDescription() throws {
		
		let cycleEnumPerennial = Cycle(rawValue: 0)
		
		XCTAssertEqual(cycleEnumPerennial?.description, "Perennial")
		
		let cycleEnumBiennial = Cycle(rawValue: 1)
		
		XCTAssertEqual(cycleEnumBiennial?.description, "Biennial")
		
		let cycleEnumAnnual = Cycle(rawValue: 2)
		
		XCTAssertEqual(cycleEnumAnnual?.description, "Annual")
		
		let cycleEnumBiannual = Cycle(rawValue: 3)
		
		XCTAssertEqual(cycleEnumBiannual?.description, "Biannual")
		
		let cycleEnumNotDefined = Cycle(rawValue: 4)
		
		XCTAssertEqual(cycleEnumNotDefined?.description, "Not defined")
		
	}
	
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


