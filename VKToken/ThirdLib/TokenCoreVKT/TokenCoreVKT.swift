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
            var meta = WalletMeta(chain: .eos, source: .privateKey);
            meta.name = "EOS";
            guard let wallet = try? WalletManager.importEOS(from: privateKeys as! [String], accountName: accountName!, permissions: permissions, encryptedBy: password!, metadata: meta)
                else {
                    return "";
            }
            return wallet.walletID as NSString;
            
        }
    }
    
    @objc(importVKTMnemonic: : : :)
    func importVKTMnemonic(mnemonic: String? = nil, accountName: String? = nil, password: String? = nil) throws -> NSString{
        do {
            var meta = WalletMeta(chain: .eos, source: .mnemonic);
            meta.name = "EOS";
            guard let wallet = try? WalletManager.importEOS(from: mnemonic!, accountName: accountName!, permissions: [], metadata: meta, encryptBy: password!, at: BIP44.eosLedger)
                else {
                    return "";
            }

            return wallet.walletID as NSString;
            
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
            return NSNumber(value: identity.wallets.count >= 3)
        }
    }
    
    @objc(getVktPublicKey:::)
    func getVktPublicKey(walletID: String? = nil, password: String? = nil) throws -> NSString{
        do {
            
            if let existWallet = try? WalletManager.findWalletByWalletID(walletID!) {
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
    
    @objc(getVktAccountName::)
    func getVktAccountName(walletID: String? = nil) throws -> NSString{
        do {
            if let existWallet = try? WalletManager.findWalletByWalletID(walletID!) {
                return NSString(string:existWallet.address)
            }else{
                return NSString("");
            }
        }
    }
    
    @objc(setVktAccountName::)
    func setVktAccountName(walletID: String? = nil, accountName: String? = nil){
        do {

            _ = try? WalletManager.setEOSAccountName(walletID:walletID!, accountName:accountName!);
        }
    }
    
    @objc(changeVktPassword:::)
    func changeVktPassword(walletID: String? = nil, oldPassword: String? = nil,  newPassword: String? = nil){
        do {
            
            _ = try? WalletManager.changePassword(walletID:walletID!, oldPassword:oldPassword!, newPassword: newPassword!);
        }
    }
    
    @objc(getVktMnemonic:::)
    func getVktMnemonic(walletID: String? = nil, password: String? = nil) throws -> NSString{
        do {
            
            if let existWallet = try? WalletManager.findWalletByWalletID(walletID!) {
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
    
    @objc(verifyWalletPassword:::)
    func verifyWalletPassword(walletID: String? = nil, password: String? = nil) throws -> NSNumber{
        do {

            if let existWallet = try? WalletManager.findWalletByWalletID( walletID! ) {
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
    
    @objc(deleteWallet:::)
    func deleteWallet(walletID: String? = nil, password: String? = nil) throws -> NSNumber{
        do {
            
            if let existWallet = try? WalletManager.findWalletByWalletID( walletID! ) {
                guard existWallet.verifyPassword(password!) else {
                    return false as NSNumber;
                }
                existWallet.delete();
                return true as NSNumber;
            }else{
                return false as NSNumber;
            }
        }
    }
    
}
