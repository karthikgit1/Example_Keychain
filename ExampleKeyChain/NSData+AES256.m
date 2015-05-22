//
//  NSData+AES256.m
//  ExampleKeyChain
//
//  Created by Vy Systems - iOS1 on 3/11/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import "NSData+AES256.h"
#import <CommonCrypto/CommonCryptor.h>
@implementation NSData (AES256)
- (NSData*)AES256EncryptWithKey:(NSString*)key {
    char keyPtr[kCCKeySizeAES256];
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSASCIIStringEncoding];
    
    NSString *iv = @"1234567812345678";
    char ivPtr[kCCKeySizeAES128];
    
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSASCIIStringEncoding];
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize           = dataLength + kCCBlockSizeAES128;
    void* buffer                = malloc(bufferSize);
    
    size_t numBytesEncrypted    = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, NULL,
                                          keyPtr, kCCKeySizeAES256,
                                          ivPtr /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

- (NSData*)AES256DecryptWithKey:(NSString*)key {
    char keyPtr[kCCKeySizeAES256];
    
    NSString *iv = @"1234567812345678";
    char ivPtr[kCCKeySizeAES128];
    
    [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSASCIIStringEncoding];
    
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSASCIIStringEncoding];
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize           = dataLength + kCCBlockSizeAES128;
    void* buffer                = malloc(bufferSize);
    
    size_t numBytesDecrypted    = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, NULL,
                                          keyPtr, kCCKeySizeAES256,
                                          ivPtr /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess)
    {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}

@end
