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
    var stringOutput: String = ""
    
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
        stringOutput = ""
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
                self.inputDisplay.text = self.stringInput + conv.inputUnit
                self.outputDisplay.text = self.stringOutput + conv.outputUnit
                self.activeConverter = conv
                self.convert()
            }))
        }
        
        self.present(alert, animated:true, completion: nil)
    }
    
    @IBAction func buttonSelection(_ sender: UIButton) {
        switch sender.tag {
        case -2:
            stringInput = ""
        case -1:
            var castedDouble: Double? = Double(stringInput)
            if (castedDouble != nil) {
                castedDouble = castedDouble! * -1
                stringInput = String(castedDouble!)
            }
        case 0...9:
            stringInput = stringInput + String(sender.tag)
        case 10:
            if stringInput.range(of: ".") != nil {
                break
            } else {
                stringInput = stringInput + "."
            }
        default:
            inputDisplay.text = inputDisplay.text
        }
        inputDisplay.text = stringInput + activeConverter!.inputUnit
        convert()
    }
    
    func convert() {
        let castedInput:Double? = Double(stringInput)
        var output:Double
        if (castedInput != nil) {
            switch activeConverter!.label {
            case "fahrenheit to celcius":
                output = Double((castedInput! - 32) * (5/9))
            case "celcius to fahrenheit":
                output = Double((castedInput! * (9/5) + 32))
            case "miles to kilometers":
                output = Double(castedInput! * 1.609344)
            case "kilometers to miles":
                output = Double(castedInput! / 1.609344)
            default:
                output = 0
            }
        }
        else {
            output = 0
        }
        stringOutput = String(output)
        outputDisplay.text = stringOutput + activeConverter!.outputUnit
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
