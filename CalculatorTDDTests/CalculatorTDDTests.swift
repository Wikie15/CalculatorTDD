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
    
    override func setUpWithError() throws {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        
        _ = viewController?.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    //MARK: TEST FOR SIMPLE STRING
    func testSimpleAdditionWorking()
    {
        viewController.stringInputField.text = "1,1"
        var result : String!
        viewController.helper.getResultAndShow(input: viewController.stringInputField.text!,tag: 1) { value, error in
            result = value
        }
        XCTAssertEqual(result,"2")
    }
    
    //MARK: TEST FOR EMPTY STRING
    func testEmptyStringCase()
    {
        viewController.stringInputField.text = ""
        var result : String!
        viewController.helper.getResultAndShow(input: viewController.stringInputField.text!,tag: 1) { value, error in
            result = value
        }
        XCTAssertEqual(result,"0")
    }
    
    //MARK: NEGATIVE NUMBER NOT ALLOWED CASE
    func negativeNumberNotAllowedCase()
    {
        viewController.stringInputField.text = "-4,6;7;2"
        var result : CalculatorErrorHandling!
        viewController.helper.getResultAndShow(input: viewController.stringInputField.text!,tag: 1) { value, error in
            result = error
        }
        XCTAssertEqual(result,.NegativeNumberNotAllowedError)
    }
    
    //MARK: NEGATIVE NUMBER  ALLOWED CASE
    func negativeNumberAllowedCase()
    {
        viewController.stringInputField.text = "-4,6;7;2"
        var result : String!
        viewController.helper.getResultAndShow(input: viewController.stringInputField.text!,tag: 1) { value, error in
            result = value
        }
        XCTAssertEqual(result,"11")
    }
    
    //MARK: NO NUMBER FOUND IN TEXTFIELD CASE
    func noNumberFoundCase()
    {
        viewController.stringInputField.text = "jdhfjkadsh"
        var result : CalculatorErrorHandling!
        viewController.helper.getResultAndShow(input: viewController.stringInputField.text!,tag: 1) { value, error in
            result = error
        }
        XCTAssertEqual(result,.NoNumbersFoundError)
    }
    
    //MARK: OPERATOR NOT CHOOSING ERROR
    func nooperatorSelectedCase()
    {
        viewController.stringInputField.text = "jdhfjkadsh"
        var result : CalculatorErrorHandling!
        viewController.helper.getResultAndShow(input: viewController.stringInputField.text!,tag: 0) { value, error in
            result = error
        }
        XCTAssertEqual(result,.chooseOperatorError)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
