//
//  CalculatorTDDTests.swift
//  CalculatorTDDTests
//
//  Created by Vignesh Devanathan on 7/1/25.
//

import XCTest
import UIKit

@testable import CalculatorTDD

final class CalculatorTDDTests: XCTestCase {

    
    var viewController : ViewController!
    var helper =  CalculatorHelper.shared
    
    override func setUpWithError() throws {
        
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
//        
//        _ = viewController?.view
    }

    override func tearDownWithError() throws {
        viewController = nil
    }
    

    //MARK: TEST FOR SIMPLE STRING
    func testSimpleAdditionWorking()
    {
        runTestAndShowResult(input: "1,1", expectedError: nil, expected: "2", tag: 1)
    }
   
    //MARK: TEST FOR EMPTY STRING
    func testEmptyStringCase()
    {
        runTestAndShowResult(input: "", expectedError: nil, expected: "0", tag: 1)
    }
    
    //MARK: NEGATIVE NUMBER NOT ALLOWED CASE
    func testnegativeNumberNotAllowedCase()
    {
        runTestAndShowResult(input: "-4,6;7;2", expectedError: .NegativeNumberNotAllowedError, expected: "", tag: 1)
    }
    
    //MARK: NO NUMBER FOUND IN TEXTFIELD CASE
    func testnoNumberFoundCase()
    {
        runTestAndShowResult(input: "jdhfjkadsh", expectedError: .NoNumbersFoundError, expected: "", tag: 1)
    }
    
    //MARK: OPERATOR NOT CHOOSING ERROR
    func testnooperatorSelectedCase()
    {
        runTestAndShowResult(input: "-4,6;7;2", expectedError: .chooseOperatorError, expected: "", tag: 0)
    }
    
    
    func runTestAndShowResult(input:String,expectedError:CalculatorErrorHandling?,expected:String,tag:Int)
    {
        let expectation = self.expectation(description: "Test \(input) = \(expected)")
            
        helper.getResultAndShow(input: input,tag: tag) { value, error in
            
            error != nil ?  XCTAssertEqual( error,expectedError)  : XCTAssertEqual( value,expected)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2) { error in
            if let error = error {
                XCTFail("Timeout waiting for result: \(error)")
            }
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
