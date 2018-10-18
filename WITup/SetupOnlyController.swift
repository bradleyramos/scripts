//
//  SetupOnlyController.swift
//  WITup
//
//  Created by Bradley Ramos on 9/27/18.
//  Copyright © 2018 Weinberg IT. All rights reserved.
//

import Cocoa
import Foundation

class SetupOnlyController: NSViewController {
    @IBOutlet weak var firstNameBox: NSTextField!
    @IBOutlet weak var lastNameBox: NSTextField!
    @IBOutlet weak var updates: NSButton!
    @IBOutlet weak var warningLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func runButtonClicked(_ sender: Any) {
        var fileURL = FileManager.default.homeDirectoryForCurrentUser
        //create path to gui_setup_notransfer.sh
        fileURL.appendPathComponent("Downloads");
        fileURL.appendPathComponent("scripts-master");
        fileURL.appendPathComponent("gui_setup_notransfer")
        fileURL.appendPathExtension("sh")
        let path = fileURL.path
        
        // checkboxes
        var launch = String()
        switch updates.state {
        case .on:
            launch = "y"
        case .off:
            launch = "n"
        case .mixed:
            print("mixed")
        default: break
        }
        
        // Run script
        var command = String()
        command = path + " '" + firstNameBox.stringValue + "' '" + lastNameBox.stringValue + "' '" + "fake unused source" + "' " + "n" + " " + launch
        warningLabel.stringValue = "Please remember to enable filevault permissions for new user"
        
        var error: NSDictionary?
        let scommand = "do shell script \"sudo sh " + command + "\" with administrator " + "privileges"
        
        NSAppleScript(source: scommand)!.executeAndReturnError(&error)
        print("error2: \(String(describing: error))")
    }
}
