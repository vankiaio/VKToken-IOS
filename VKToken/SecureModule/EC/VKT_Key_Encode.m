//
//  VKT_Key_Encode.m
//  wif_test
//
//  Created by vankiachain on 2018/3/14.
//  Copyright © 2018年 宋赓. All rights reserved.
//

#import "VKT_Key_Encode.h"
#include "sha2.h"
#include "uECC.h"
#include "libbase58.h"
#include "rmd160.h"
#include <errno.h>
#include <inttypes.h>
#include <stdio.h>
#import "NSObject+Extension.h"
#include <stdlib.h>
#include <string.h>

@implementation VKT_Key_Encode


/**
 validate wif format
 */
+ (BOOL)validateWif:(NSString *)wif{
    if (!(wif.length > 0)) {
        NSLog(@"parameter wif can't be nil!");
        return NO;
    }
    const char *b58 = [wif UTF8String];
    unsigned char bin[100];
    size_t binlen=37;
    b58tobin(bin, &binlen, b58, strlen(b58));
    if (bin[0] != 0x80) {
        NSLog(@"parameter wif header bytes validate failed!");
        return NO;
    }
    
    //validateWif has some bug,this time fixed it.
    unsigned char hexChar[33]; // getRandomHexBytes[32]
    unsigned char digest[32];
    unsigned char result[32]; // Recieve randomHexByes hash result
    unsigned char last4Bytes[4];
//    memcpy(hexChar, bin+1, 32);
    memcpy(hexChar, bin, 33);
    memcpy(last4Bytes, bin+33, 4);
    sha256_Raw(hexChar, 33, digest);
    sha256_Raw(digest, 32, digest);
    memcpy(result, digest, 4);
//    if (!strcmp(result, last4Bytes) ) {
     if (memcmp(result, last4Bytes,4) ) {
        NSLog(@"parameter wif hash validate failed!");
        return NO;
    }
    return YES;
}
//const char *b58 = [wif UTF8String];
//unsigned char bin[100];
//size_t binlen=37;
//b58tobin(bin, &binlen, b58, strlen(b58));
//if (bin[0] != 0x80) {
//    return NO;
//}
//unsigned char *hexChar; // getRandomHexBytes[32]
//unsigned char digest[32];
//unsigned char *result; // Recieve randomHexByes hash result
//unsigned char *last4Bytes;
//memcpy(hexChar, bin+1, 32);
//memcpy(last4Bytes, bin+33, 4);
//sha256_Raw(hexChar, 33, digest);
//sha256_Raw(result, 32, digest);
//if (!strcmp(result, last4Bytes) ) {
//    return NO;
//}
//return YES;
/**
 getRandomBytesDataWithWif
 */
+ (NSData*)getRandomBytesDataWithWif:(NSString *)wif{
    if (!(wif.length > 0)) {
        NSLog(@"parameter wif can't be nil!");
        return nil;
    }
    const char *b58 = [wif UTF8String];
    unsigned char bin[100];
    size_t binlen=37;
    b58tobin(bin, &binlen, b58, strlen(b58));
    if (bin[0] != 0x80) {
        NSLog(@"parameter wif header bytes validate failed!");
        return nil;
    }
    unsigned char hexChar[33]; // getRandomHexBytes[33]
    unsigned char digest[32];
    unsigned char result[32]; // Recieve randomHexByes hash result
    unsigned char last4Bytes[4];
    memcpy(hexChar, bin+1, 32);
    memcpy(last4Bytes, bin+33, 4);
    sha256_Raw(hexChar, 33, digest);
    sha256_Raw(digest, 32, digest);
    memcpy(result, digest, 4);
    if (!strcmp(result, last4Bytes) ) {
        NSLog(@"parameter wif hash validate failed!");
        return nil;
    }
    NSData *data = [NSData dataWithBytes:hexChar length:32];
    return data;
}

/**
 wif_with_random_bytes_data
 @param random_bytesData random_bytesData
 @return wif
 */
+ (NSString *)wif_with_random_bytes_data:(NSData *)random_bytesData{
    const char *privateKey = [random_bytesData bytes];
    //    memcpy(str, privateKey, 32);
    unsigned char result[37];
    result[0] = 0x80;
    unsigned char digest[32];
    int len;
    char wif[100];
    memcpy(result + 1 , privateKey, 32);
    sha256_Raw(result, 33, digest);
    sha256_Raw(digest, 32, digest);
    memcpy(result+33, digest, 4);
    b58enc(wif, &len, result,37);
    return [NSString stringWithUTF8String:wif];
}


/**
 vkt_publicKey_with_wif
 
 @param wif wif
 @return vkt_publicKey
 */
+ (NSString *)vkt_publicKey_with_wif:(NSString *)wif{
    unsigned char pri[32];
    const char *baprik = [wif UTF8String];
    unsigned char result[37];
    unsigned char digest[32];
    char base[100];
    unsigned char *hash;
    size_t len = 100;
    size_t klen = 37;
    
    uint8_t pub[64];
    uint8_t cpub[33];
    
    if (b58tobin(result, &klen, baprik, wif.length)) {
        printf("success\n");
    }
    
    memcpy(pri, result+1, 32);
    
    uECC_compute_public_key(pri, pub);
    
    result[0] = 0x80;
    memcpy(result+1, pri, 32);
    sha256_Raw(result, 33, digest);
    sha256_Raw(digest, 32, digest);
    memcpy(result+33, digest, 4);
    b58enc(base, &len, result, 37);
    
    uECC_compress(pub, cpub);
    hash = RMD(cpub, 33);
    memcpy(result, cpub, 33);
    memcpy(result+33, hash, 4);
    b58enc(base, &len, result, 37);

    NSString *vktPubKey = [NSString stringWithFormat:@"VKT%@", [NSString stringWithUTF8String:base]];
    return vktPubKey;
}

/**
 encode uecc_publicKey --> vkt_PublicKey
 @param uecc_publicKey_bytes_data uecc_publicKey_bytes_data
 @return vkt_PublicKey
 */
+ (NSString *)encode_vkt_PublicKey_with_uecc_publicKey_bytes_data:(NSData *)uecc_publicKey_bytes_data{
    uint8_t pub = [uecc_publicKey_bytes_data bytes];
    uint8_t cpub[33];
    char *hash;
    unsigned char reslt[37];
    char base[100];
    int len;
    uECC_compress(pub,cpub);
    hash = RMD(cpub, 33);
    memcpy(reslt, cpub, 33);
    memcpy(reslt+33, hash, 4);
    b58enc(base, &len, reslt,37);
    return [NSString stringWithFormat:@"VKT%@", [NSString stringWithUTF8String:base]];;
}

/**
 decode vkt_PublicKey --> uecc_publicKey_bytes_data
 @param vkt_publicKey uecc_publicKey_bytes_data
 @return uecc_publicKey_bytes_data
 */
+ (NSData *)decode_vkt_publicKey:(NSString *)vkt_publicKey{
    if (!(vkt_publicKey.length > 0)) {
        NSLog(@"parameter vkt_publicKey can't be nil!");
        return nil;
    }
    if (![vkt_publicKey hasPrefix:@"VKT"]) {
        NSLog(@"parameter vkt_publicKey has not prefix 'VKT'!");
        return nil;
    }
    const char *b58 = [[vkt_publicKey substringFromIndex:3] UTF8String];
    unsigned char bin[100];
    size_t binlen = 37;
    unsigned char *hash;
    
    unsigned char checkValue[33];
    unsigned char validateHash[4];
    uint8_t pub[64];
    b58tobin(bin, &binlen, b58, strlen(b58));
    
    [NSObject out_Hex:bin andLength:binlen];
    
    
    memcpy(checkValue, bin, 33 );
    memcpy(validateHash, bin+33, 4);
    
    
    hash = RMD(checkValue, 33);
    
    
    for(int i=0;i<4;i++){
        if(validateHash[i]!=hash[i]){
            NSLog(@"parameter vkt_publicKey validate failed!");
            return nil;
        }
    }
    
    uECC_decompress(checkValue, pub);
    
    return [NSData dataWithBytes:pub length:sizeof(pub)];
}

@end

