//
//  VKT_Key_Encode.h
//  wif_test
//
//  Created by vankiachain on 2018/3/14.
//  Copyright © 2018年 宋赓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VKT_Key_Encode : NSObject
/**
 validate wif format
 */
+ (BOOL)validateWif:(NSString *)wif;

/**
 getRandomBytesDataWithWif
 */
+ (NSData*)getRandomBytesDataWithWif:(NSString *)wif;

/**
 wif_with_random_bytes_data
 @param random_bytesData random_bytesData
 @return wif
 */
+ (NSString *)wif_with_random_bytes_data:(NSData *)random_bytesData;

/**
 vkt_publicKey_with_wif
 
 @param wif wif
 @return vkt_publicKey
 */
+ (NSString *)vkt_publicKey_with_wif:(NSString *)wif;



/**
 encode uecc_publicKey --> vkt_PublicKey
 @param uecc_publicKey_bytes_data uecc_publicKey_bytes_data
 @return vkt_PublicKey
 */
+ (NSString *)encode_vkt_PublicKey_with_uecc_publicKey_bytes_data:(NSData *)uecc_publicKey_bytes_data;


/**
 decode vkt_PublicKey --> uecc_publicKey_bytes_data
 @param vkt_publicKey uecc_publicKey_bytes_data
 @return uecc_publicKey_bytes_data
 */
+ (NSData *)decode_vkt_publicKey:(NSString *)vkt_publicKey;




@end

