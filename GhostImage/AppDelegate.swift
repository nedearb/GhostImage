//
//  AppDelegate.swift
//  GhostImage
//
//  Created by Braeden Atlee on 7/6/17.
//  Copyright © 2017 Braeden Atlee. All rights reserved.
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
        dialog.allowedFileTypes = NSImage.imageTypes();
        
        if(dialog.runModal() == NSModalResponseOK){
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
        if(sender.state == NSOnState){
            mainImageView.imageScaling = NSImageScaling.scaleAxesIndependently;
            sender.state = NSOffState;
        }else{
            mainImageView.imageScaling = NSImageScaling.scaleProportionallyUpOrDown;
            sender.state = NSOnState;
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

