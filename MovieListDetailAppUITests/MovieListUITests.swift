//
//  MovieListUITests.swift
//  MovieListDetailApp
//
//  Created by Luciano Uchoa on 23/09/25.
//


import XCTest

final class MovieListUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testSelectFirstCell() throws {
        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        firstCell.tap()
        let overviewText = app.staticTexts["overviewLabelIdentifier"]
        XCTAssertTrue(overviewText.waitForExistence(timeout: 5))
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.tables.firstMatch.exists)
    }
    
    func testScrollAndSelectTenthCell() throws {
        let table = app.tables.firstMatch
        XCTAssertTrue(table.waitForExistence(timeout: 5))
        let tenthCell = table.cells.element(boundBy: 9)
        while !tenthCell.isHittable {
            table.swipeUp()
        }
        tenthCell.tap()
        let overviewText = app.staticTexts["overviewLabelIdentifier"]
        XCTAssertTrue(overviewText.waitForExistence(timeout: 5))
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.tables.firstMatch.exists)
    }
    
    func testPullToRefresh() throws {
        let tableView = app.tables.firstMatch
        XCTAssertTrue(tableView.waitForExistence(timeout: 5))
        
        let firstCell = tableView.cells.firstMatch
        XCTAssertTrue(firstCell.exists)
        
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 6.0))
        start.press(forDuration: 0.1, thenDragTo: finish)
        
        sleep(2)
        
        XCTAssertGreaterThan(tableView.cells.count, 0)
    }
}

