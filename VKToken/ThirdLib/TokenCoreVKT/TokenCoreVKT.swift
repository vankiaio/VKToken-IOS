//
//  TokenCoreVKT.swift
//  TokenCoreVKT
//
//  Created by 李轶 on 2019/5/16.
//  Copyright © 2019 vankiachain. All rights reserved.
//

import Foundation
import TokenCore

@objc(TokenCoreVKT)
public class TokenCoreVKT:NSObject{
    static let instance: TokenCoreVKT = TokenCoreVKT()
    
    @objc(requestResult)
    var requestResult:String = ""
    
    @objc(sharedTokenCoreVKT)
    class func sharedTokenCoreVKT() -> TokenCoreVKT {
        return instance
    }
    
    
    @objc(generateIdentity: : :)
    func generateIdentity(mnemonic: String? = nil, password: String? = nil) throws -> NSString{
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
                identity = try Identity.recoverIdentity(metadata: metadata, mnemonic: mnemonic, password: password!)
            } else {
                (mnemonicStr, identity) = try Identity.createIdentity(password: password!, metadata: metadata)
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
            return mnemonicStr as NSString
        } catch {
            print("createIdentity failed, error:\(error)")
        }
        requestResult = "unknown error"
        return ""
    }
    
    @objc(importVKTPrivateKey: : : : :)
    func importVKTPrivateKey(privateKey: String? = nil, publicKey: String? = nil, accountName: String? = nil, password: String? = nil) throws -> NSString{
        do {

            let privateKeys = [
                privateKey,
                privateKey
            ]
            let permissions = [
                EOS.PermissionObject(permission: "owner", publicKey: publicKey! , parent: ""),
                EOS.PermissionObject(permission: "active", publicKey: publicKey! , parent: "")
            ]
            guard let wallet = try? WalletManager.importEOS(from: privateKeys as! [String], accountName: accountName!, permissions: permissions, encryptedBy: password!, metadata: WalletMeta(chain: .eos, source: .privateKey))
                else {
                    return "";
            }
            return wallet.walletID as NSString;
            
        }
    }
    
    @objc(importVKTMnemonic: : : :)
    func importVKTMnemonic(mnemonic: String? = nil, accountName: String? = nil, password: String? = nil) throws -> NSString{
        do {
           guard let wallet = try? WalletManager.importEOS(from: mnemonic!, accountName: accountName!, permissions: [], metadata: WalletMeta(chain: .eos, source: .mnemonic), encryptBy: password!, at: BIP44.eos)
            else {
                return "";
            }
            return wallet.walletID as NSString;
            
        }
    }
    
    @objc(deriveEosWallet:)
    func deriveEosWallet(password: String? = nil) {
        do {
            guard let identity = Identity.currentIdentity else {
                requestResult = "Pls create or recover an identity first"
                return
            }
            let wallets = try! identity.deriveWallets(for: [.eos], password: password!)
            let eosWallet = wallets.first!
            requestResult = "Derived EOS Wallet by identity mnemonic success:\n"
            requestResult = requestResult + prettyPrintJSON(eosWallet.serializeToMap())
        }
    }
    
    @objc(getVktPrivateKey::)
    func getVktPrivateKey(password: String? = nil) throws -> NSString{
        do {
            guard let identity = Identity.currentIdentity else {
                requestResult = "Pls create or recover an identity first"
                return NSString("");
            }
            
            if let existWallet = try? WalletManager.findWalletByAddress( identity.wallets.first { (wallet) -> Bool in
                return wallet.imTokenMeta.chain == .eos}!.address, on: .eos) {
                return NSString(string:try! existWallet.privateKeys(password: password!)[0].privateKey)
            }else{
                return NSString("");
            }
        }
    }
    
    @objc(getVktPrivateKey:::)
    func getVktPrivateKey(walletID: String? = nil, password: String? = nil) throws -> NSString{
        do {
            
            if let existWallet = try? WalletManager.findWalletByWalletID(walletID!) {
                return NSString(string:try! existWallet.privateKeys(password: password!)[0].privateKey)
            }else{
                return NSString("");
            }
        }
    }
    
    @objc(hasVktWallet:)
    func hasVktWallet() throws -> NSNumber{
        do {
            guard let identity = Identity.currentIdentity else {
                requestResult = "Pls create or recover an identity first"
                return NSNumber(value: 0);
            }
            return NSNumber(value: identity.wallets.count == 3)
        }
    }
    
    @objc(getVktPublicKey::)
    func getVktPublicKey(password: String? = nil) throws -> NSString{
        do {
            guard let identity = Identity.currentIdentity else {
                requestResult = "Pls create or recover an identity first"
                return NSString("");
            }
            
            if let existWallet = try? WalletManager.findWalletByAddress( identity.wallets.first { (wallet) -> Bool in
                return wallet.imTokenMeta.chain == .eos}!.address, on: .eos) {
                return NSString(string:try! existWallet.privateKeys(password: password!)[0].publicKey)
            }else{
                return NSString("");
            }
        }
    }
    
    @objc(getVktAccountName:)
    func getVktAccountName() throws -> NSString{
        do {
            guard let identity = Identity.currentIdentity else {
                requestResult = "Pls create or recover an identity first"
                return NSString("");
            }
            
            if let existWallet = try? WalletManager.findWalletByAddress(identity.wallets.first { (wallet) -> Bool in
                return wallet.imTokenMeta.chain == .eos}!.address, on: .eos) {
                return NSString(string:existWallet.address)
            }else{
                return NSString("");
            }
        }
    }
    
    @objc(setVktAccountName:)
    func setVktAccountName(accountName: String? = nil){
        do {
            guard let identity = Identity.currentIdentity else {
                requestResult = "Pls create or recover an identity first"
                return 
            }
            
            if let existWallet = try? WalletManager.findWalletByAddress(identity.wallets.first { (wallet) -> Bool in
                return wallet.imTokenMeta.chain == .eos}!.address, on: .eos) {
                _ = try? WalletManager.setEOSAccountName(walletID:existWallet.walletID, accountName:accountName!)
            }
        }
    }
    
    @objc(setVktAccountName::)
    func setVktAccountName(walletID: String? = nil, accountName: String? = nil){
        do {
            guard let identity = Identity.currentIdentity else {
                requestResult = "Pls create or recover an identity first"
                return
            }
            
            if let existWallet = try? WalletManager.findWalletByAddress(identity.wallets.first { (wallet) -> Bool in
                return wallet.imTokenMeta.chain == .eos && wallet.walletID == walletID}!.address, on: .eos) {
                _ = try? WalletManager.setEOSAccountName(walletID:existWallet.walletID, accountName:accountName!)
            }
        }
    }
    
    @objc(getVktMnemonic::)
    func getVktMnemonic(password: String? = nil) throws -> NSString{
        do {
            guard let identity = Identity.currentIdentity else {
                requestResult = "Pls create or recover an identity first"
                return NSString("");
            }
            
            if let existWallet = try? WalletManager.findWalletByAddress( identity.wallets.first { (wallet) -> Bool in
                return wallet.imTokenMeta.chain == .eth}!.address, on: .eth) {
                return NSString(string:try! existWallet.exportMnemonic(password: password!))
            }else{
                return NSString("");
            }
        }
    }
    
    @objc(findVktWalletID::)
    func findVktWalletID(accountName: String? = nil) throws -> NSString{
        do {
            guard let identity = Identity.currentIdentity else {
                requestResult = "Pls create or recover an identity first"
                return NSString("");
            }
            
            if let existWallet = try? WalletManager.findWalletByAddress( identity.wallets.first { (wallet) -> Bool in
                return wallet.imTokenMeta.chain == .eth && wallet.address == accountName}!.address, on: .eth) {
                return NSString(string: existWallet.walletID)
            }else{
                return NSString("");
            }
        }
    }
    
    @objc(verifyWalletPassword::)
    func verifyWalletPassword(password: String? = nil) throws -> NSNumber{
        do {
            guard let identity = Identity.currentIdentity else {
                requestResult = "Pls create or recover an identity first"
                return false as NSNumber;
            }
            
            if let existWallet = try? WalletManager.findWalletByAddress( identity.wallets.first { (wallet) -> Bool in
                return wallet.imTokenMeta.chain == .eth}!.address, on: .eth) {
                return try! existWallet.verifyPassword(password!) as NSNumber
            }else{
                return false as NSNumber;
            }
        }
    }

    @objc(isValidMnemonic::)
    func isValidMnemonic(mnemonic: String? = nil) throws -> NSNumber{
        do {
            let validator = MnemonicValidator(mnemonic!);
            let boolIsValid = validator.isValid;
            return boolIsValid as NSNumber;
        }
    }
    
}
