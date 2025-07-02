//
//  UserDefualtsHelper.swift
//  CalculatorTDD
//
//  Created by Vignesh Devanathan on 7/2/25.
//

import Foundation

class UserDefualtsHelper {
    
    static let shared = UserDefualtsHelper()
    
    //MARK: NEGATIVE NUMBER ENABLED OR NOT GET
    func isNegativeNumberEnabled() -> Bool?
    {
        return UserDefaults.standard.bool(forKey: "isNegativeNumberEnabled")
    }
    
    //MARK: SET BOOL VALUE FOR NEGATIVE SWITCH ACTION
    func setNegativeNumberEnabled(_ enabled: Bool) {
        UserDefaults.standard.set(enabled, forKey: "isNegativeNumberEnabled")
    }
    

}
