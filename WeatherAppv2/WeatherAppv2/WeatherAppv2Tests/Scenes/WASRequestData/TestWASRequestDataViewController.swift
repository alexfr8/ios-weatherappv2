//
//  TestWASRequestData.swift
//  WeatherAppv2Tests
//
//  Created by Alejandro Fernández Ruiz on 31/07/2019.
//  Copyright © 2019 Alejandro Fernández Ruiz. All rights reserved.
//


@testable import WeatherAppv2
import XCTest

class TestWASRequestDataViewController: XCTestCase {
    // MARK: Subject under test
    
    var sut:  WARequestDataViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupWARequestDataViewController()
    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupWARequestDataViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "WARequestDataViewController", bundle: bundle)
        sut = storyboard.instantiateInitialViewController() as? WARequestDataViewController
    }
    
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Spies
    
    class WARequestDataPresenterLogicSpy: WARequestDataPresenterLogic {
        
        var setupViewCalled = false
        var manageSearchButtonClickedCalled = false
        var setupTextCalled = false
      
        func setupView() {
            setupViewCalled = true
        }
        
        func manageSearchButtonClicked() {
            manageSearchButtonClickedCalled = true
        }
        
        func setupText(text: String) {
            setupTextCalled = true
        }
        
    }
    
    // MARK: Tests
    
    func testShouldSetupViewWhenViewIsLoaded() {
        // Given
        let spy = WARequestDataPresenterLogicSpy()
        sut.presenter = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.setupViewCalled, "viewDidLoad() should ask the presenter to setup View")
    }
    
    
    func testSetupText() {
        //GIVEN
        let viewModel = WARequestData.ViewModel()
        
        //WHEN
        loadView()
        sut.setupText(viewModel: viewModel)
        //THEN
        
        XCTAssert(sut.btnShow.titleLabel?.text == NSLocalizedString("datarequest.button.title", comment: ""))
    }

    
}
