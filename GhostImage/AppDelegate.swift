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
    @IBOutlet weak var menuItemFullOpacity: NSMenuItem!
    
    
    @IBOutlet weak var menuItemMaintainAspectRatio: NSMenuItem!
    @IBOutlet weak var menuItemActualSize: NSMenuItem!
    
    var actualSize: Bool = false;
    var maintainAspectRatio: Bool = true;
    var opacityPercent: Int = 100;
    
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Init
        
        updateOpacityItemsEnabled();
        
        mainImageView.imageAlignment = NSImageAlignment.alignCenter;
        updateImageScaling();
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
    
    func boolToState(_ input: Bool) -> NSControl.StateValue {
       return input ? NSControl.StateValue.on : NSControl.StateValue.off
    }
    
    func updateImageScaling() {
        if (actualSize) {
            mainImageView.imageScaling = NSImageScaling.scaleNone;
        } else {
            if (maintainAspectRatio) {
                mainImageView.imageScaling = NSImageScaling.scaleProportionallyUpOrDown;
            } else {
                mainImageView.imageScaling = NSImageScaling.scaleAxesIndependently;
            }
        }
        
        menuItemActualSize.state = boolToState(actualSize);
        
        menuItemMaintainAspectRatio.isEnabled = !actualSize;
        menuItemMaintainAspectRatio.state = boolToState(actualSize || maintainAspectRatio);
        
    }
    
    func updateOpacityItemsEnabled(){
        menuItemIncOpacity.isEnabled = opacityPercent < 100;
        menuItemDecOpacity.isEnabled = opacityPercent > 10;
        menuItemFullOpacity.isEnabled = opacityPercent != 100;
        window.alphaValue = CGFloat(opacityPercent) / 100.0;
    }
    
    @IBAction func onMenuAspectRatio(_ sender: NSMenuItem) {
        maintainAspectRatio = !maintainAspectRatio;
        updateImageScaling();
    }
    
    @IBAction func onMenuActualSize(_ sender: NSMenuItem) {
        actualSize = !actualSize;
        updateImageScaling();
    }
    
    @IBAction func onMenuIncOpacity(_ sender: NSMenuItem) {
        if(opacityPercent < 100){
            opacityPercent = min(opacityPercent+10, 100);
        }
        updateOpacityItemsEnabled();
    }

    @IBAction func onMenuDecOpacity(_ sender: NSMenuItem) {
        if(opacityPercent > 10){
            opacityPercent = max(opacityPercent-10, 10);
        }
        updateOpacityItemsEnabled();
    }
    
    @IBAction func onMenuFullOpacity(_ sender: NSMenuItem) {
        opacityPercent = 100;
        updateOpacityItemsEnabled();
    }
}

