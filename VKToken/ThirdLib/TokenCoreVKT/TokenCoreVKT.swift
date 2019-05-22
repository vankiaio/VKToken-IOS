//
//  TokenCoreVKT.swift
//  TokenCoreVKT
//
//  Created by 李轶 on 2019/5/16.
//  Copyright © 2019 vankiachain. All rights reserved.
//

import Foundation
import TokenCore
@objc(WRAPTokenCoreVKT)
public class TokenCoreVKT:NSObject{
    @objc(requestResult)
    var requestResult:String = ""
    
    
    @objc(generateIdentity:)
    func generateIdentity(mnemonic: String? = nil) {
        do {
            var mnemonicStr: String = ""
            let isCreate = mnemonic == nil
            let source = isCreate ? WalletMeta.Source.newIdentity : WalletMeta.Source.recoveredIdentity
            var metadata = WalletMeta(source: source)
            metadata.network = Network.testnet
            metadata.segWit = .p2wpkh
            
            metadata.name = isCreate ? "MyFirstIdentity" : "MyRecoveredIdentity"
            let identity: Identity
            if let mnemonic = mnemonic {
                mnemonicStr = mnemonic
                identity = try Identity.recoverIdentity(metadata: metadata, mnemonic: mnemonic, password: Constants.password)
            } else {
                (mnemonicStr, identity) = try Identity.createIdentity(password: Constants.password, metadata: metadata)
            }
            
            var result = ""
            result.append("\n")
            result.append("The mnemonic:\n")
            result.append(mnemonicStr)
            result.append("\n")
            
            identity.wallets.forEach { wallet in
                result.append(prettyPrintJSON(wallet.serializeToMap()))
                result.append("\n")
            }
            requestResult = result
            return
        } catch {
            print("createIdentity failed, error:\(error)")
        }
        requestResult = "unknown error"
    }
    
    @objc(importEthPrivateKey)
    func importEthPrivateKey() {
        do {
            if let existWallet = try? WalletManager.findWalletByAddress("41983f2e3af196c1df429a3ff5cdecc45c82c600", on: .eth) {
                _ = existWallet.delete()
            }
            
            let meta = WalletMeta(chain: .eth, source: .privateKey)
            let ethWallet = try! WalletManager.importFromPrivateKey(Constants.testPrivateKey, encryptedBy: Constants.password, metadata: meta)
            requestResult = "Import ETH Wallet by PrivateKey success:\n"
            requestResult = requestResult + prettyPrintJSON(ethWallet.serializeToMap())
            
        }
    }
    
    @objc(deriveEosWallet)
    func deriveEosWallet() {
        do {
            if let existWallet = try? WalletManager.findWalletByAddress("n2ZNV88uQbede7C5M5jzi6SyG4GVuPpng6", on: .btc) {
                _ = existWallet.delete()
            }
            
            guard let identity = Identity.currentIdentity else {
                requestResult = "Pls create or recover an identity first"
                return
            }
            let wallets = try! identity.deriveWallets(for: [.eos], password: Constants.password)
            let eosWallet = wallets.first!
            requestResult = "Derived EOS Wallet by identity mnemonic success:\n"
            requestResult = requestResult + prettyPrintJSON(eosWallet.serializeToMap())
        }
    }
}
