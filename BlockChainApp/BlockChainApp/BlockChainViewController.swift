//  BlockChainViewController.swift
//  BlockChainApp
//  Created by Debasis Das on 4/7/23.

import Cocoa
import Foundation

class BlockChainViewController: NSViewController, NSCollectionViewDataSource, NSCollectionViewDelegate,NSCollectionViewDelegateFlowLayout {

    @IBOutlet weak var newBlockTransactionTextView: NSTextView!
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet weak var powDifficulty: NSSlider!
    var blockChain: Blockchain!
    
    
    @IBAction func mineAndAddBlock(_ sender:Any){
        let tData = self.newBlockTransactionTextView.string
        if (tData != ""){
            self.blockChain.addBlock(data: tData,powDifficulty: self.powDifficulty.integerValue)
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func checkBlockChainValidity(_ sender: Any){
        let alert = NSAlert()
        if (self.blockChain.validateChain()){
            alert.messageText = "Valid"
            alert.informativeText = "Yes the block chain is Valid."
            alert.addButton(withTitle: "OK")
        } else{
            alert.messageText = "In-Valid"
            alert.informativeText = "Blockchain is not valid"
            alert.addButton(withTitle: "OK")
        }

        let response = alert.runModal()
        if response == .alertFirstButtonReturn {
            print("Do Nothing")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NSNib(nibNamed: "BlockItemView", bundle: nil), forItemWithIdentifier: NSUserInterfaceItemIdentifier("BlockItemView"))
    }

    // MARK: - NSCollectionViewDataSource

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        //return items.count
        self.blockChain.chain.count
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier("BlockItemView"), for: indexPath)
        guard let itemView = item as? BlockItemView else {
            return item
        }
        
        if let block = self.blockChain.chain[indexPath.item] as? Block{
            itemView.indexTextField.stringValue = "\(block.index)"
            itemView.timeStampTextField.stringValue = "\(block.timestamp)"
            itemView.previousHashTextField.stringValue = block.previousHash
            itemView.blockHashTextField.stringValue = block.hash
            itemView.nonceTextField.stringValue = block.nonce
            itemView.dataTextField.stringValue = block.data
        }
        return item
    }

    // MARK: - NSCollectionViewDelegate
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize {
        return NSSize(width: 337, height: 280)
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, insetForSectionAt section: Int) -> NSEdgeInsets {
            return NSEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}
