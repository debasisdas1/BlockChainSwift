//  AppDelegate.swift
//  BlockChainApp
//  Created by Debasis Das on 4/5/23.

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!
    var viewController:BlockChainViewController!

    func createConstraints(baseView: NSView, subView:NSView){
        subView.translatesAutoresizingMaskIntoConstraints = false
        let variableBindings = ["subView": subView]
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subView]-0-|",options: .alignAllLastBaseline, metrics: nil, views: variableBindings)
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subView]-0-|",options: .alignAllLastBaseline, metrics: nil, views: variableBindings)
        baseView.addConstraints(vConstraints)
        baseView.addConstraints(hConstraints)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let blockchain = Blockchain()
        self.viewController = BlockChainViewController(nibName: "BlockChainViewController", bundle: .main)
        self.viewController.blockChain = blockchain
        
        self.window.contentView?.addSubview(self.viewController.view)
        self.createConstraints(baseView: self.window.contentView!, subView: self.viewController.view)
    }
}


