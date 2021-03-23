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
    
    @IBAction func onMenuAspectRatio(_ sender: NSMenuItem) {
        if(sender.state == NSControl.StateValue.on){
            mainImageView.imageScaling = NSImageScaling.scaleAxesIndependently;
            sender.state = NSControl.StateValue.off;
        }else{
            mainImageView.imageScaling = NSImageScaling.scaleProportionallyUpOrDown;
            sender.state = NSControl.StateValue.on;
        }
    }
    
    func updateOpacityItemsEnabled(){
        menuItemIncOpacity.isEnabled = window.alphaValue < 1.0;
        menuItemDecOpacity.isEnabled = window.alphaValue > 0.1;
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

