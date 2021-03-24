//
//  AppDelegate.swift
//  GhostImage
//
//  Created by Emily Atlee on 7/6/17.s
//  Copyright © 2021 Emily Atlee. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var mainImageView: NSImageView!
    
    @IBOutlet weak var menuItemDecOpacity: NSMenuItem!
    @IBOutlet weak var menuItemIncOpacity: NSMenuItem!
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Init
        
        window.alphaValue = 1.0;
        updateOpacityItemsEnabled();
        
        mainImageView.imageAlignment = NSImageAlignment.alignCenter;
        setMaintainAspectRatio(true);
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Cleanup
    }
    
    func setImage(_ path: String){
        mainImageView.image = NSImage(byReferencingFile: path);
    }

    @IBAction func onMenuOpen(_ sender: NSMenuItem) {
        
        let dialog = NSOpenPanel();
        
        dialog.title = "Choose an image...";
        dialog.allowedFileTypes = NSImage.imageTypes;
        
        if(dialog.runModal() == NSApplication.ModalResponse.OK){
            let result = dialog.url;
            if(result != nil){
                let path = result!.path;
                setImage(path);
            }
            
        }else{
            // Pressed cancel
        }
        
    }
    
    func setMaintainAspectRatio(_ maintain: Bool) {
        if(maintain){
            mainImageView.imageScaling = NSImageScaling.scaleProportionallyUpOrDown;
        }else{
            mainImageView.imageScaling = NSImageScaling.scaleAxesIndependently;
        }
    }
    
    func updateOpacityItemsEnabled(){
        menuItemIncOpacity.isEnabled = window.alphaValue < 1.0;
        menuItemDecOpacity.isEnabled = window.alphaValue > 0.1;
    }
    
    @IBAction func onMenuAspectRatio(_ sender: NSMenuItem) {
        let turnOn = sender.state == NSControl.StateValue.off;
        sender.state = turnOn ? NSControl.StateValue.on : NSControl.StateValue.off;
        
        setMaintainAspectRatio(turnOn);
    }
    
    @IBAction func onMenuIncOpacity(_ sender: NSMenuItem) {
        if(window.alphaValue < 1.0){
            window.alphaValue += 0.1;
        }
        updateOpacityItemsEnabled();
    }

    @IBAction func onMenuDecOpacity(_ sender: NSMenuItem) {
        if(window.alphaValue > 0.1){
            window.alphaValue -= 0.1;
        }
        updateOpacityItemsEnabled();
    }
    
    @IBAction func onMenuFullOpacity(_ sender: NSMenuItem) {
        window.alphaValue = 1.0;
        updateOpacityItemsEnabled();
    }
}

