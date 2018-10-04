//
//  TransferOnlyController.swift
//  WITup
//
//  Created by Bradley Ramos on 9/26/18.
//  Copyright © 2018 Weinberg IT. All rights reserved.
//

import Cocoa
import Foundation

class TransferOnlyController: NSViewController {
    @IBOutlet weak var sourceField: NSTextField!
    @IBOutlet weak var sourceButton: NSButton!
    @IBOutlet weak var destinationField: NSTextField!
    @IBOutlet weak var destinationButton: NSButton!
    @IBOutlet weak var libraryFiles: NSButton!
    @IBOutlet weak var runButton: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    @IBAction func sourceClicked(_ sender: Any) {
        
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
    @IBAction func destinationClicked(_ sender: Any) {
        
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
                destinationField.stringValue = path
            }
        } else {
            // User clicked on "Cancel"
            return
        }
        
    }
    
    var fileURL = FileManager.default.homeDirectoryForCurrentUser
    
    @IBAction func runClicked(_ sender: Any) {
        //create path to simple_setup.sh
        fileURL.appendPathComponent("Downloads");
        fileURL.appendPathComponent("scripts-master");
        fileURL.appendPathComponent("transfer")
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
        
        // Run script
        var command = String()
        let source = sourceField.stringValue
        let destination = destinationField.stringValue
        command = path + " '" + destination + "' " + "admin" + " '" + source + "' " + lib
        
        var error: NSDictionary?
        let scommand = "do shell script \"sudo sh " + command + "\" with administrator " + "privileges"
        
        NSAppleScript(source: scommand)!.executeAndReturnError(&error)
        
        print("error2: \(String(describing: error))")
    }
    
    
}
