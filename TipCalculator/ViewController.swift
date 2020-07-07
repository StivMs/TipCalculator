//
//  ViewController.swift
//  TipCalculator
//
//  Created by Stivan Mersho on 2020-06-22.
//  Copyright © 2020 Stivan Mersho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var amount: Double?
    var sliderValue: Double = 15.0
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var tipPrecentageLabel: UILabel!
    @IBOutlet weak var tipSliderValue: UISlider!
    @IBOutlet weak var tipAmountLabel: UILabel!
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    // Get value from slider, convert it and assign it to the label
    @IBAction func tipSlider(_ sender: Any) {
        // Check first if textfield has any values to calcualte
        guard let input = amountTextField.text, !input.isEmpty else {
            showMessage(title: "Error!", message: "Add amount first!")
            return
        }
        sliderValue = Double(tipSliderValue.value).rounded()
        
        // Remove unncessary decimals
        let sliderValueShort = String(format: "%.0f", sliderValue)
        tipPrecentageLabel.text = String("Tip (\(sliderValueShort)%)")
        changeAmountLabel()
        totalAmountToPay()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addDoneButtonOnKeyboard()
        amountTextField.becomeFirstResponder()
        // Dont allow movement on the slider at the start
        tipSliderValue.isEnabled = false
        
    }
    
    // Calculate total tips
    func getTotalTips() -> Double {
        return Double((amount!*sliderValue/100))
    }
    
    func changeAmountLabel(){
        tipAmountLabel.text = String("$\(String(format: "%.2f", getTotalTips()))")
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.amountTextField.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction()
    {
        guard let input = amountTextField.text, !input.isEmpty else {
            showMessage(title: "Error!", message: "Add amount first!")
            return
        }
        self.amountTextField.resignFirstResponder()
        let amountString = self.amountTextField.text
        amount = Double(amountString!)
        
        self.amountTextField.text = "$\(String(format: "%.2f", amount!))"
        changeAmountLabel()
        totalAmountToPay()
        tipSliderValue.isEnabled = true
    }
    
    func totalAmountToPay(){
        let totalPayment = amount!+getTotalTips()
        print("Total amount to pay: \(totalPayment)")
        totalAmountLabel.text = "$\(String(format: "%.2f", totalPayment))"
    }
    
    
    func showMessage(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    
}

