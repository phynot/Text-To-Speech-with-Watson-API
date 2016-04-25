//
//  CustomController.swift
//  Speak to Me
//
//  Created by Kay Lab on 4/21/16.
//  Copyright © 2016 Kay Lab. All rights reserved.
//

import UIKit
import WatsonDeveloperCloud
import AVFoundation

class CustomController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func synthesizeCustom(sender: UIButton) {
        var text = customText.text!
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
    
    @IBOutlet weak var customText: UITextField!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
