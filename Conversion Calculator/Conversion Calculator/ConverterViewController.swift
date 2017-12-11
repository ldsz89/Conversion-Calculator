//
//  ConverterViewController.swift
//  Conversion Calculator
//
//  Created by Shannon, Leandre D. (MU-Student) on 11/9/17.
//  Copyright © 2017 Shannon, Leandre D. (MU-Student). All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    @IBOutlet weak var inputDisplay: UITextField!
    @IBOutlet weak var outputDisplay: UITextField!
    
    var stringInput: String = ""
    
    var converters = [Converter(label: "fahrenheit to celcius", inputUnit: "°F", outputUnit: "°C"),
                      Converter(label: "celcius to fahrenheit", inputUnit: "°C", outputUnit: "°F"),
                      Converter(label: "miles to kilometers", inputUnit: "mi", outputUnit: "km"),
                      Converter(label: "kilometers to miles", inputUnit: "km", outputUnit: "mi")]
    
    var activeConverter: Converter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputDisplay.text = converters[0].inputUnit
        outputDisplay.text = converters[0].outputUnit
        
        stringInput = ""
        activeConverter = converters[0]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func converterButton(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Choose Converter", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        for conv in converters {
            alert.addAction(UIAlertAction(title: conv.label, style: UIAlertActionStyle.default, handler: { (alertAction) in
                self.inputDisplay.text = conv.inputUnit
                self.outputDisplay.text = conv.outputUnit
                self.activeConverter = conv
            }))
        }
        
        self.present(alert, animated:true, completion: nil)
    }
    
    @IBAction func buttonSelection(_ sender: UIButton) {
        switch sender.tag {
        case -2:
            stringInput = ""
        case -1:
            var castedInt: Int? = Int(stringInput)
            if (castedInt != nil) {
                castedInt = castedInt! * -1
                stringInput = String(castedInt!)
            }
        case 0..<10:
            stringInput = stringInput + String(sender.tag)
        case 10:
            if stringInput.contains(".") {
                break
            } else {
                stringInput = stringInput + "."
            }
        default:
            inputDisplay.text = inputDisplay.text
        }
        inputDisplay.text = stringInput + activeConverter!.inputUnit
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
