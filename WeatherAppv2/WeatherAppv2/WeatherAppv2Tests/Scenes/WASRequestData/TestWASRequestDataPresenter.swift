//
//  TestWASRequestDataPresenter.swift
//  WeatherAppv2Tests
//
//  Created by Alejandro Fernández Ruiz on 31/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//


@testable import WeatherAppv2
import XCTest

class TestWASRequestDataPresenter: XCTestCase {
    // MARK: Subject under test
    
    var sut: WARequestDataPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupWARequestDataPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupWARequestDataPresenter() {
        sut = WARequestDataPresenter()
    }
    
    // MARK: Spies
    
    class WARequestDataDisplayLogicSpy: WARequestDataPresenterRouterLogic, WARequestDataDisplayLogic {
        
        
        var navigateToDataShowCalled = false
        var setupViewCalled = false
        var setupTextCalled = false
        var showLoadingCalled = false
        var dimissLoadingCalled = false
        var showErrorCalled = false
        
        func navigateToDataShow(zeroPosition: Current) {
            navigateToDataShowCalled = true
        }
        
        func setupView() {
            setupViewCalled = true
        }
        
        func setupText(viewModel: WARequestData.ViewModel) {
            setupTextCalled = true
        }
        
        func showLoading() {
            showLoadingCalled = true
        }
        
        func dismissLoading() {
            dimissLoadingCalled = true
        }
        
        func showError(msg: String) {
            showErrorCalled = true
        }
        
    }
    
    // MARK: Tests
    
    func testManageSearchButtonClicked() {
        //Given
        let spy = WARequestDataDisplayLogicSpy()
        sut.view = spy
        
        //When
        
        sut.manageSearchButtonClicked()
        
        //Then
        XCTAssertTrue(true)
        //asyncronous calling
       
    }
    
    func testSetupText() {
        //Given
        let spy = WARequestDataDisplayLogicSpy()
        sut.view = spy
        let testText = "this is a text to test"
        
        //When
        
        sut.setupText(text: testText)
        //Then
        XCTAssertTrue(sut.textToSearch == testText)
      
    }
   
}
