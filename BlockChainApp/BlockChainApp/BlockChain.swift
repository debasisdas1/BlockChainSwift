//  BlockChain.swift
//  BlockChainApp
//  Created by Debasis Das on 4/5/23.

import Foundation
import CommonCrypto

struct Block: Codable {
    let index: Int
    let timestamp: TimeInterval
    let data: String
    let previousHash: String
    var nonce: String
    let hash: String

    init(index: Int, timestamp: TimeInterval, data: String, previousHash: String,powDifficulty:Int=1) {
        self.index = index
        self.timestamp = timestamp
        self.data = data
        self.previousHash = previousHash
        let tuple = Block.calculateHash(index: index, timestamp: timestamp, data: data, previousHash: previousHash,powDifficulty: powDifficulty)
        self.hash = tuple.0
        self.nonce = tuple.1
    }
    
    static func recalculateHash(index: Int, timestamp: TimeInterval, data: String, previousHash: String,nonce:String)->String{
        let message = "\(index)\(timestamp)\(data)\(previousHash)\(nonce)"
        if let messageData = message.data(using: .utf8) {
            var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            messageData.withUnsafeBytes {
                _ = CC_SHA256($0.baseAddress, UInt32(messageData.count), &digest)
            }
            let hash = digest.map { String(format: "%02x", $0) }.joined()
            return hash
        }
        return ""
    }
    
    static func calculateHash(index: Int, timestamp: TimeInterval, data: String, previousHash: String,powDifficulty:Int = 1) -> (String,String) {
        var nonce = 0
        var flag:Bool = true
        while(flag){
            nonce += 1
            let message = "\(index)\(timestamp)\(data)\(previousHash)\(nonce)"
            if let messageData = message.data(using: .utf8) {
                var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
                messageData.withUnsafeBytes {
                    _ = CC_SHA256($0.baseAddress, UInt32(messageData.count), &digest)
                }
                let hash = digest.map { String(format: "%02x", $0) }.joined()
                
                let subString = hash.prefix(powDifficulty)
                var valid = true
                for char in subString{
                    if char != "0"{
                        valid = false
                    }
                }
                if valid{
                    print(data,hash,nonce)
                    flag = false
                    return (hash,"\(nonce)")
                }
                
            }
        }
        return ("","0")
    }
}

class Blockchain {
    var chain: [Block] = []
    var pendingTransactions: [String] = []

    init() {
        createGenesisBlock()
    }

    func createGenesisBlock() {
        let genesisBlock = Block(index: 0, timestamp: Date().timeIntervalSince1970, data: "Genesis Block", previousHash: "0",powDifficulty: 1)
        chain.append(genesisBlock)
    }
    
    func addBlock(data: String, powDifficulty:Int) {
        let previousBlock = chain.last!
        let block = Block(index: chain.count, timestamp: Date().timeIntervalSince1970, data: data, previousHash: previousBlock.hash,powDifficulty: powDifficulty)
        chain.append(block)
    }

    func validateChain() -> Bool {
        for i in 1..<chain.count {
            let block = chain[i]
            let previousBlock = chain[i-1]
            if block.hash != Block.recalculateHash(index: block.index, timestamp: block.timestamp, data: block.data, previousHash: previousBlock.hash, nonce: block.nonce){
                return false
            }
        }
        return true
    }
}

