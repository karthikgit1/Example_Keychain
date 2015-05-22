//
//  NSString+Aes256.h
//  ExampleKeyChain
//
//  Created by Vy Systems - iOS1 on 3/11/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
@interface NSString (Aes256)
- (NSData*)AES256EncryptWithKey:(NSString*)key;
- (NSData*)AES256DecryptWithKey:(NSString*)key;
@end
