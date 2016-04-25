//
//  ViewController.swift
//  Speak to Me
//
//  Created by Kay Lab on 4/19/16.
//  Copyright © 2016 Kay Lab. All rights reserved.
//

import UIKit
import WatsonDeveloperCloud
import AVFoundation

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
var name : String? = ""
class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    let tts = TextToSpeech(username: "YOUR_USERNAME", password: "YOUR_PASSWORD")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        let topColor = UIColor(red: (30/255.0), green: (144/255.0), blue: (255/255.0), alpha: 1)
        let bottomColor = UIColor(red: (0/255.0), green: (255/255.0), blue: (127/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.CGColor, bottomColor.CGColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, atIndex: 0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var nameUserWot: UITextField!
    
     @IBAction func userDoneEditing(sender: AnyObject) {
        print("asdasdsadsadasd")
        let textFieldName = nameUserWot.text!
        name = textFieldName
        print(name)
    }


    @IBAction func synthesizeText(sender: UIButton) {
        print(name)
        var text = sender.currentTitle!
        print("hello")
        print(name)
        switch text {
            case "Hello":
                text = "Hello there"
            case "Name":
                text = "My name is " + name!
            case "Inquire":
                text = "How are you doing?"
            case "Good":
                text = "Good"
            case "Bad":
                text = "Bad"
            case "Okay":
                text = "Okay"
            case "Bye":
                text = "Good-bye"
            case "Bathroom":
                text = "I need to go to the bathroom"
            case "Yes":
                break
            case "No":
                break
            case "Maybe":
                break
            case "Welcome":
                text = "You're welcome"
            case "Help":
                text = "I need help!"
            case "Thanks":
                text = "Thank you"
            case "Hungry":
                text = "I am hungry"
            case "Thirsty":
                text = "I require liquid sustenance"
            
            default:
                text = "I'm batman"
        }
        text = "<speak>" + text + "</speak>"
        print(text)
        tts.synthesize(text, voice: "en-US_AllisonVoice"){
            data, error in
            
            if let audio = data {
                
                do {
                    self.player = try AVAudioPlayer(data: audio)
                    self.player!.play()
                } catch {
                    print("Couldn't create player.")
                }
                
            } else {
                print(error)
            }
            
        }

    }

    @IBAction func synthesizeCustom(sender: UIButton) {
        var text = customText.text!
        let tonation = toneLabel.text!
        switch tonation {
            case "No Intonation Set":
                text = "<speak>" + text + "</speak>"
            case "Sincere/Apologetic":
                text = "<speak><express-as type=\"Apology\">" + text + "</express-as></speak>"
            case "Uncertain/Skeptical":
                text = "<speak><express-as type=\"Uncertainty\">" + text + "</express-as></speak>"
            case "Upbeat/Good News":
                text = "<speak><express-as type=\"GoodNews\">" + text + "</express-as></speak>"
            default:
                print("woo")

        }
        print(text)
        tts.synthesize(text, voice: "en-US_AllisonVoice"){
            data, error in
            
            if let audio = data {
                
                do {
                    self.player = try AVAudioPlayer(data: audio)
                    self.player!.play()
                } catch {
                    print("Couldn't create player.")
                }
                
            } else {
                print(error)
            }
            
        }
        
    }

    
    
    //tone stuff
    
    @IBOutlet weak var customText: UITextField!
    @IBOutlet weak var toneSlider: UISlider!
    @IBOutlet weak var toneLabel: UILabel!

    @IBAction func toneValueChanged(sender: UISlider) {
        let currentValue = Int(sender.value)
        
        switch currentValue {
        case 0..<25:
            toneLabel.text = "No Intonation Set"
        case 25..<50:
            toneLabel.text = "Sincere/Apologetic"
        case 50..<75:
            toneLabel.text = "Uncertain/Skeptical"
        case 75..<101:
            toneLabel.text = "Upbeat/Good News"
        default:
            toneLabel.text = "sdfdsfdsfds"
        }
        
    
    
    }
}
    

