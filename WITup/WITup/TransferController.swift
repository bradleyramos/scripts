//
//  TransferController.swift
//  WITup
//
//  Created by Bradley Ramos on 9/20/18.
//  Copyright © 2018 Weinberg IT. All rights reserved.
//

import Cocoa
import Foundation

class TransferController: NSViewController {
    @IBOutlet weak var sourceButton: NSButton!
    @IBOutlet weak var sourceField: NSTextField!
    @IBOutlet weak var firstName: NSTextField!
    @IBOutlet weak var lastName: NSTextField!
    @IBOutlet weak var libraryFiles: NSButton!
    @IBOutlet weak var launchUpdates: NSButton!
    @IBOutlet weak var runCommands: NSButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    @IBAction func selectDirectory(_ sender: Any) {
        
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a directory";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = true;
        dialog.canChooseDirectories    = true;
        dialog.canCreateDirectories    = true;
        dialog.allowsMultipleSelection = false;
        dialog.canChooseFiles          = false;
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                sourceField.stringValue = path
            }
        } else {
            // User clicked on "Cancel"
            return
        }
        
    }
    
    // Set up bash scripting
    @discardableResult
    func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
    
    var fileURL = FileManager.default.homeDirectoryForCurrentUser;
    
    @IBAction func runSetup(_ sender: Any) {
        //create path to simple_setup.sh
        fileURL.appendPathComponent("Desktop");
        fileURL.appendPathComponent("github");
        fileURL.appendPathComponent("simple_setup")
        fileURL.appendPathExtension("sh")
        let path = fileURL.path
        
        // checkboxes
        var lib = String()
        switch libraryFiles.state {
        case .on:
            lib = "y"
        case .off:
            lib = "n"
        case .mixed:
            print("mixed")
        default: break
        }
        var launch = String()
        switch launchUpdates.state {
        case .on:
            launch = "y"
        case .off:
            launch = "n"
        case .mixed:
            print("mixed")
        default: break
        }
        shell("sudo","sh",path,firstName.stringValue,lastName.stringValue,sourceField.stringValue,lib,launch)
    }


}
