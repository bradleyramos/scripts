//
//  FileVaultViewController.swift
//  WITup
//
//  Created by Bradley Ramos on 12/6/18.
//  Copyright © 2018 Weinberg IT. All rights reserved.
//

import Cocoa
import Foundation


class FileVaultViewController: NSViewController {
    @IBOutlet weak var enableFileVault: NSButton!
    @IBOutlet weak var userInput: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    @IBAction func runClicked(_ sender: Any) {
        // Finds scripts location by moving back twich from .app bundle location.
        var bundPath = Bundle.main.bundleURL
        bundPath = bundPath.deletingLastPathComponent()
        bundPath = bundPath.deletingLastPathComponent()
        
        // Creates actual location of base script
        let scriptName = "filevault_setup.sh"
        let path = bundPath.path + "/" + scriptName
        
        // Run script
        var command = String()
        command = "'" + path + "' '" + username + "' '" + userInput.stringValue + "'"
        
        var error: NSDictionary?
        let scommand = "do shell script \"sudo sh " + command + "\" with administrator " + "privileges"
        
        NSAppleScript(source: scommand)!.executeAndReturnError(&error)
        
        print("error2: \(String(describing: error))")
    }
}
