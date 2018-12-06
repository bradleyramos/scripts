//
//  SetupOnlyController.swift
//  WITup
//
//  Created by Bradley Ramos and John Wu on 9/27/18.
//  Copyright © 2018 Weinberg IT. All rights reserved.
//

import Cocoa
import Foundation

class SetupOnlyController: NSViewController {
    @IBOutlet weak var firstNameBox: NSTextField!
    @IBOutlet weak var lastNameBox: NSTextField!
    @IBOutlet weak var updates: NSButton!
    @IBOutlet weak var warningLabel: NSTextField!
    @IBOutlet weak var aPass: NSSecureTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func runButtonClicked(_ sender: Any) {
        
        // Finds scripts location by moving back twich from .app bundle location.
        var bundPath = Bundle.main.bundleURL
        bundPath = bundPath.deletingLastPathComponent()
        bundPath = bundPath.deletingLastPathComponent()
        
        // Creates actual location of base script
        let scriptName = "simple_setup.sh"
        let scriptPath = bundPath.path + "/"
        let path = bundPath.path + "/" + scriptName
        
        
//        var fileURL = FileManager.default.homeDirectoryForCurrentUser
//        //create path to gui_setup_notransfer.sh
//        fileURL.appendPathComponent("Downloads");
//        fileURL.appendPathComponent("scripts-master");
//        fileURL.appendPathComponent("gui_setup_notransfer")
//        fileURL.appendPathExtension("sh")
//        let path = fileURL.path
        
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
        
        warningLabel.stringValue = "Script is running. Please Wait."
        // Run script
        var command = String()
        let capName = lastNameBox.stringValue
        let username = capName.lowercased().replacingOccurrences(of: " ", with: "_")
        command = "'" + path + "' '" + firstNameBox.stringValue + "' '" + lastNameBox.stringValue + "' 'nosource' n " + launch + " n n '" + scriptPath + "'"

        var error: NSDictionary?
        let scommand = "do shell script \"sudo sh " + command + "\" with administrator " + "privileges"

        NSAppleScript(source: scommand)!.executeAndReturnError(&error)
        print("error1: \(String(describing: error))")
        
        // Reset path for filevault setup
        let FVName = "filevault_setup.sh"
        let FVPath = bundPath.path + "/" + FVName
        // Run script
        var FVcommand = String()
        FVcommand = "'" + FVPath + "' '" + username + "' '" + aPass.stringValue + "'"
        
        var FVerror: NSDictionary?
        let FVscommand = "do shell script \"sudo sh " + FVcommand + "\" with administrator " + "privileges"
        
        NSAppleScript(source: FVscommand)!.executeAndReturnError(&FVerror)
        print("error2: \(String(describing: FVerror))")
        warningLabel.stringValue = "Script has completed running."
    }
}
