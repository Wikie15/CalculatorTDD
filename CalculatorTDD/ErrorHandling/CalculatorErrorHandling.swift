//
//  CalculatorErrorHandling.swift
//  CalculatorTDD
//
//  Created by Vignesh Devanathan on 7/1/25.
//

enum CalculatorErrorHandling : Error
{
    case EmptyStringPassedError
    case NegativeNumberNotAllowedError
    case NoNumbersFoundError
    case MethodNotProcessedError
    case UnexpectedCharacterError
    case chooseOperatorError
}
