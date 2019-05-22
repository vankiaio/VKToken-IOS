//
//  TokenCoreVKT.swift
//  TokenCoreVKT
//
//  Created by 李轶 on 2019/5/16.
//  Copyright © 2019 vankiachain. All rights reserved.
//

import Foundation
import TokenCore

open class TokenCoreVKT:NSObject{
    var requestResult = ""
    
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
}
