//  BlockItemView.swift
//  BlockChainApp
//  Created by Debasis Das on 4/7/23.

import Cocoa

class BlockItemView: NSCollectionViewItem {

    @IBOutlet weak var indexTextField: NSTextField!
    @IBOutlet weak var timeStampTextField: NSTextField!
    @IBOutlet weak var previousHashTextField: NSTextField!
    @IBOutlet weak var blockHashTextField: NSTextField!
    @IBOutlet weak var nonceTextField: NSTextField!
    @IBOutlet weak var dataTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor(calibratedRed: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
    }
    
}
