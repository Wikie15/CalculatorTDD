//
//  CalculatorHelper.swift
//  CalculatorTDD
//
//  Created by Vignesh Devanathan on 7/1/25.
//


import Foundation

class CalculatorHelper
{
    static let shared = CalculatorHelper()
    var intResults : [Int]?
    let defaultHelper = UserDefualtsHelper.shared
    
    
    
    //MARK: GET INT VALUES FROM STRING
    func getIntFromStringAndDoMath( text: String!,tag:Int) throws -> String
    {
        
        var result : String = ""
        
        
        if text.isEmpty
        {
            result = "0"
        }
        else if tag == 0
        {
            throw  CalculatorErrorHandling.chooseOperatorError
        }
        else
        {
            do
            {
                let regex = try NSRegularExpression(pattern: "-?\\d+")
                let nsString = text as NSString
                let results = regex.matches(in: text, range: NSMakeRange(0, nsString.length))
                intResults =  results.map{Int(nsString.substring(with: $0.range))!}
                
                guard let intResult = intResults else { return "" }
                
                if  self.defaultHelper.isNegativeNumberEnabled() == false && intResult.contains(where: {$0 < 0})
                {
                    throw CalculatorErrorHandling.NegativeNumberNotAllowedError
                }
                else if intResult.isEmpty
                {
                    throw CalculatorErrorHandling.NoNumbersFoundError
                }
                else
                {
                    let value = intResult.reduce( tag == 3 ? 1 : 0, (tag == 1 ? (+) : tag == 2 ? (-) : (*) ))
                    result = "\(value)"
                }
            }
            catch
            {
                throw error
            }
        }
        
        return result
    }
    
    //MARK: SHOW THE VALUE FROM METHOD RESULT
    func getResultAndShow(input: String,tag:Int, completion: @escaping (String,CalculatorErrorHandling?) -> Void)
    {
        do
        {
            completion(try getIntFromStringAndDoMath(text: input, tag: tag), nil)
        }
        catch
        {
            if error as? CalculatorErrorHandling == .NegativeNumberNotAllowedError
            {
                let negativeResults = intResults?.filter({$0 < 0}).map({String($0)})
                let allValues = negativeResults!.joined(separator: ",")
                completion(allValues,error as? CalculatorErrorHandling)
            }
            else
            {
                completion("",error as? CalculatorErrorHandling)
            }
        }
    }
    
    
    
    
}
