//
//  TestUtilsCoord.swift
//  WeatherAppv2Tests
//
//  Created by Alejandro Fernández Ruiz on 31/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//

@testable import WeatherAppv2
import XCTest
import MapKit

class TestUtilsCoord: XCTestCase {

    let madridLat: Double = 40.41
    let madridLong: Double = -3.70
    var madridCoord: CLLocationCoordinate2D?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        madridCoord  = CLLocationCoordinate2D(latitude: madridLat, longitude: madridLong)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        madridCoord = nil
    }
    
    
    func testMadrid0km() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //GIVEN
        
        //WHEN
        guard let coord = madridCoord else {
            XCTAssert(false)
            return
        }
        let result = UtilsCoord.shared.coordinates(startingCoordinates: coord, atDistance: 0, atAngle: 0)
        //a position near Teruel
        let resultLatString = String(format:"%.2f",  result.latitude)
        let resultLongString = String(format:"%.2f",  result.longitude)
        let madridLatString = String(format:"%.2f",  madridLat)
         let madridLongString = String(format:"%.2f",  madridLong)
        
        //THEN
        
        XCTAssertNotNil(result)
        
        XCTAssertTrue(resultLatString == madridLatString)
        XCTAssertTrue(resultLongString == madridLongString)
    }
    
    
    func testMadrid0position() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //GIVEN
        
        //WHEN
        
        let result = UtilsCoord.shared.coordinates(startingCoordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0), atDistance: 0, atAngle: 0)
        //a position near Teruel
        //THEN
        
        XCTAssertNotNil(result)
        
        XCTAssertTrue(result.latitude == 0)
        XCTAssertTrue(result.longitude == 0)
    }
    
    
    func testMadridEastCoordinates() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //GIVEN
        
        //WHEN
        guard let coord = madridCoord else {
            XCTAssert(false)
            return
        }
        let result = UtilsCoord.shared.coordinates(startingCoordinates: coord, atDistance: 200, atAngle: 90)
       //a position near Teruel
        
        //THEN
        XCTAssertNotNil(result)
        XCTAssertTrue(result.longitude > madridLong)
    }

    func testMadridWestCoordinates() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //GIVEN
        
        //WHEN
        guard let coord = madridCoord else {
            XCTAssert(false)
            return
        }
        let result = UtilsCoord.shared.coordinates(startingCoordinates: coord, atDistance: 200, atAngle: 270)
        //a position near Villanueva del Conde
        
        //THEN
        XCTAssertNotNil(result)
        XCTAssertTrue(result.longitude < madridLong)
    }


    func testMadridNorhtCoordinates() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //GIVEN
        
        //WHEN
        guard let coord = madridCoord else {
            XCTAssert(false)
            return
        }
        let result = UtilsCoord.shared.coordinates(startingCoordinates: coord, atDistance: 200, atAngle: 0)
        //a position near Burgos
        
        //THEN
        XCTAssertNotNil(result)
        XCTAssertTrue(result.latitude > madridLat)
    }
    
    func testMadridSouthCoordinates() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //GIVEN
        
        //WHEN
        guard let coord = madridCoord else {
            XCTAssert(false)
            return
        }
        let result = UtilsCoord.shared.coordinates(startingCoordinates: coord, atDistance: 200, atAngle: 180)
        //a position near Puertollano
        
        //THEN
        XCTAssertNotNil(result)
        XCTAssertTrue(result.latitude < madridLat)
    }
}
