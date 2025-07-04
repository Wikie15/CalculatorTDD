//
//  ViewController.swift
//  CalculatorTDD
//
//  Created by Vignesh Devanathan on 7/1/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var holderView: UIView!
    
    @IBOutlet weak var selectedOperatorLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var stringInputField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var subtractButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var negativeSwitch: UISwitch!
    @IBOutlet weak var equalButton: UIButton!
    
    
    let helper = CalculatorHelper.shared
    let defaultsHelper = UserDefualtsHelper.shared
    var tag = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIAndMethod()
        
    }

    //MARK: BUTTON ACTIONS AND SHOW RESULT
    @IBAction func doMathAndShowResult(_ sender: UIButton) {
        
        helper.getResultAndShow(input: stringInputField.text!,tag: self.tag)
        { value,calError in
            
            if calError == nil
            {
                self.resultLabel.text = value
            }
            else
            {
                self.showAlertController(message: calError == .NegativeNumberNotAllowedError ? ("\(calError!) \n Negative Values provided: " + (value)) : "\(calError!)")
            }
        }
        
    }
    
    @IBAction func changeTag(_ sender: UIButton) {
        self.tag = sender.tag
        self.selectedOperatorLabel.text = self.tag == 1 ? "+" : "-"
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        clearFields()
    }
    
    
    func clearFields()
    {
        self.stringInputField.text = ""
        self.resultLabel.text = ""
        self.selectedOperatorLabel.text = ""
        self.tag = 0
    }
    
    //MARK: ALERT CONTROLLER SHOWING ERROR FROM STRING AND OTHER PROCESS
    func showAlertController(message: String)
    {
        let alert = UIAlertController(title: "Error", message:message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { action in
            self.clearFields()
        }
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
     
    //MARK: SET SWITCH TOGGLE WHEN ACTION
    @objc func setNegativeSwitch()
    {
        self.negativeSwitch.setOn( !(defaultsHelper.isNegativeNumberEnabled() ?? false), animated: true)
        self.defaultsHelper.setNegativeNumberEnabled(self.negativeSwitch.isOn)
    }

}

extension ViewController
{
    //MARK: BASIC UI AND METHOD SETUP
    func setUIAndMethod()
    {
        // we can create custom button or view by creating custom class and use that in Interface Builder or storybaord. I chose to go as simplfied  version of using modifiers here.
        holderView.layer.cornerRadius = 10
        topView.layer.cornerRadius = 10
        
        calculateButton.addCornerAndClip()
        subtractButton.addCornerAndClip()
        resetButton.addCornerAndClip()
        equalButton.addCornerAndClip()
        
        stringInputField.tintColor = .white
        stringInputField.becomeFirstResponder()
        stringInputField.font = UIFont(name: "Digital-7", size: 30)
        resultLabel.font = UIFont(name: "Digital-7", size: 30)
        selectedOperatorLabel.font = UIFont(name: "Digital-7", size: 30)
        self.negativeSwitch.isOn = defaultsHelper.isNegativeNumberEnabled() ?? false
        self.negativeSwitch.addTarget(self, action: #selector(setNegativeSwitch), for: .valueChanged)
        
    }
}

extension UIView {
    func addCornerAndClip()
    {
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
}
