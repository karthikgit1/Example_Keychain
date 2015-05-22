//
//  ViewController.m
//  ExampleKeyChain
//
//  Created by Vy Systems - iOS1 on 9/4/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

#include <stdlib.h>

#import "singleton.h"
#import "AESCrypt.h"
#import <CommonCrypto/CommonCryptor.h>
#import "FBEncryptorAES.h"

#import "RNEncryptor.h"
#import "RNCryptor.h"

#import "NSString+AESCrypt.h"
#import "NSData+AESCrypt.h"


///********use malloc instaed
/*Do not store encryption keys or other critical data
 inside Objective-C instance variables, as they can be
 easily referenced. Instead, manually allocate memory
 for these. This will not stop an attacker from hooking
 into your application with a debugger, but will up the
 ante for an attacker. Typically, if a device is
 compromised while the user is using it, the attack is
 automated malware rather than an active human.
 */



@interface ViewController ()
{
    NSString *username;
    NSString *password ;
    NSString *secretkey;
    
  
    
    //char* p12;
}
@end



@implementation ViewController




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.sample.keychain" accessGroup:nil];
    
  // int *lotteryNumbers = malloc(sizeof(int) * 6);
    
    [self showToolBar];

    //buf = CFBridgingRelease(malloc(100*sizeof(char)));
    
   // NSString* p = (string*)malloc(sizeof(string)*12);
    
    /*
     p12 = (char*)malloc(sizeof(char)*12);
    
    strcpy(p12,"Sy#m$1cK%@");
     free(p12);
    NSLog(@"p12 is %s",p12);
    */
   
    
}


-(void)showToolBar
{
    //UIToolbar *toolbar = [[UIToolbar alloc]  init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    
    
    toolbar.barStyle = UIBarStyleDefault; [toolbar sizeToFit];
    //toolbar.frame = CGRectMake(0, 410,  320,  50);
    
    //Add  buttons
  
    
    //Use  this  to put space  in between your  toolbox buttons
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                 target:nil
                                 action:nil];
    
    UIBarButtonItem *barbtn1 = [ViewController customWithImage:[UIImage imageNamed:@"personal5.png"]
                                                  enabled:true target:self action:@selector(pressButton3)];
    
    UIBarButtonItem *barbtn2 = [ViewController customWithImage:[UIImage imageNamed:@"smart.png"]
                                                  enabled:true target:self action:@selector(pressButton3)];
    
    UIBarButtonItem *barbtn3 = [ViewController customWithImage:[UIImage imageNamed:@"personal5.png"]
                                                       enabled:true target:self action:@selector(pressButton3)];
    
    UIBarButtonItem *barbtn4 = [ViewController customWithImage:[UIImage imageNamed:@"smart.png"]
                                                       enabled:true target:self action:@selector(pressButton3)];
    
    barbtn4.enabled = false;
    
    UIBarButtonItem *barbtn5 = [ViewController customWithImage:[UIImage imageNamed:@"personal5.png"]
                                                       enabled:true target:self action:@selector(pressButton3)];
    
    UIBarButtonItem *barbtn6 = [ViewController customWithImage:[UIImage imageNamed:@"smart.png"]
                                                       enabled:true target:self action:@selector(pressButton3)];

    
    //Add  buttons to the array
    NSArray *items  = [NSArray arrayWithObjects: barbtn1, flexItem,
                       barbtn2, flexItem, barbtn3,
                       flexItem,barbtn4,flexItem,barbtn5,flexItem,barbtn6,nil];
    
    //add  array  of buttons to toolbar
    [toolbar setItems:items animated:NO];
    
    //To  Disable a button  inside  the UiToolBar systemItem5.enabled = false;
    
    [self.view addSubview:toolbar];
}

+ (UIBarButtonItem *)customWithImage:(UIImage *)image enabled:
(BOOL)enabled target:(id)target action:(SEL)selector
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //I've  tried  different values  for the frame  here,  but no luck
    button.frame = CGRectMake(0, 0, 44, 44);
    button.enabled = enabled;
    button.showsTouchWhenHighlighted = YES;
    [button addTarget:target action:selector
     forControlEvents:UIControlEventTouchUpInside];
    [button setImage:image forState:UIControlStateNormal];
    
    UIBarButtonItem *it = [[UIBarButtonItem alloc]
                           initWithCustomView:button] ;
    //Tried changing this,  to no avail
    it.width = 32.f;
    return  it;
}

-(void)pressButton3
{
    NSLog(@"btn pressed");
}

-(void)viewWillAppear:(BOOL)animated
{
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Button Methods
- (IBAction)saveUserDetails:(id)sender
{
    
     wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.sample.keychain" accessGroup:nil];
    username = @"PA-37";
//    password = @"PassWord";
//    secretkey = @"SecretKey";
    
    //NSString *encryptedPwd = [AESCrypt encrypt:password password:SYMMETRICKEY];
    NSString *encryptedPwd = [AESCrypt encrypt:password password:[NSString stringWithFormat:@"%s", [singleton getData]]];
    
    NSLog(@"encryptedData is %@",encryptedPwd);
    
    [wrapper setObject:encryptedPwd forKey:(__bridge id)(kSecValueData)];
    
    
    NSString *encryptedUname = [AESCrypt encrypt:username password:[NSString stringWithFormat:@"%s", [singleton getData]]];
    
    NSLog(@"encryptedUname is %@",encryptedUname);
    
    [wrapper setObject:encryptedUname forKey:(__bridge id)(kSecAttrAccount)];
    
    
    NSString *encryptedSecreKey = [AESCrypt encrypt:secretkey password:[NSString stringWithFormat:@"%s", [singleton getData]]];
    
    NSLog(@"encrypted Secret key is %@",encryptedSecreKey);
    
    [wrapper setObject:encryptedSecreKey forKey:(__bridge id)(kSecAttrService) ];
    
    
    
    
}

- (IBAction)showEncrypteddata:(id)sender
{
    
    
    
     wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.sample.keychain" accessGroup:nil];
    
   
    
    NSString *_stringfromkeychain;
    NSData *_datafrmkeychain,*_archive;
    id obj;
    
    /********************************************
     *********Get Password from keychain*************
     ****************************************
     */
    _stringfromkeychain = [wrapper objectForKey:(__bridge id)(kSecValueData)];
    ;
    
   // NSLog(@"somestring is %@",_stringfromkeychain);
     _archive = [NSKeyedArchiver archivedDataWithRootObject:_stringfromkeychain];
  
    obj = [NSKeyedUnarchiver unarchiveObjectWithData:_archive];
    if ([obj isKindOfClass:[NSString class]])
    {
        NSLog(@"nsstring");
        
        NSString *message = [AESCrypt decrypt:_stringfromkeychain password:[NSString stringWithFormat:@"%s", [singleton getData]]];
        
        NSLog(@"decryped pwd is %@",message);
    }
    else if ([obj isKindOfClass:[NSData class]])
    {
            NSLog(@"NsData");
        
        _datafrmkeychain = [wrapper objectForKey:(__bridge id)(kSecValueData)];
        
        NSString *message = [AESCrypt decrypt:[[NSString alloc] initWithData:_datafrmkeychain encoding:NSUTF8StringEncoding] password:[NSString stringWithFormat:@"%s", [singleton getData]]];
        
        NSLog(@"decryped pwd is %@",message);
    }
    
    
    /********************************************
     *********Get Username from keychain*************
     ****************************************
     */
    _stringfromkeychain = [wrapper objectForKey:(__bridge id)(kSecAttrAccount)];
    ;
    
    //NSLog(@"somestring is %@",_stringfromkeychain);
    _archive = [NSKeyedArchiver archivedDataWithRootObject:_stringfromkeychain];
    
    obj = [NSKeyedUnarchiver unarchiveObjectWithData:_archive];
    if ([obj isKindOfClass:[NSString class]])
    {
        NSLog(@"nsstring");
        
        NSString *message = [AESCrypt decrypt:_stringfromkeychain password:[NSString stringWithFormat:@"%s", [singleton getData]]];
        
        NSLog(@"decryped Username is %@",message);
    }
    else if ([obj isKindOfClass:[NSData class]])
    {
        NSLog(@"NsData");
        
        _datafrmkeychain = [wrapper objectForKey:(__bridge id)(kSecAttrAccount)];
        
        NSString *message = [AESCrypt decrypt:[[NSString alloc] initWithData:_datafrmkeychain encoding:NSUTF8StringEncoding] password:[NSString stringWithFormat:@"%s", [singleton getData]]];
        
        NSLog(@"decryped Username is %@",message);
    }
    
    /********************************************
     *********Get SecretKey from keychain*************
     ****************************************
     */
    _stringfromkeychain = [wrapper objectForKey:(__bridge id)(kSecAttrService)];
    ;
    
    //NSLog(@"somestring is %@",_stringfromkeychain);
    _archive = [NSKeyedArchiver archivedDataWithRootObject:_stringfromkeychain];
    
    obj = [NSKeyedUnarchiver unarchiveObjectWithData:_archive];
    if ([obj isKindOfClass:[NSString class]])
    {
        NSLog(@"nsstring");
        
        NSString *message = [AESCrypt decrypt:_stringfromkeychain password:[NSString stringWithFormat:@"%s", [singleton getData]]];
        
        NSLog(@"decryped Secretkey is %@",message);
    }
    else if ([obj isKindOfClass:[NSData class]])
    {
        NSLog(@"NsData");
        
        _datafrmkeychain = [wrapper objectForKey:(__bridge id)(kSecAttrService)];
        
        NSString *message = [AESCrypt decrypt:[[NSString alloc] initWithData:_datafrmkeychain encoding:NSUTF8StringEncoding] password:[NSString stringWithFormat:@"%s", [singleton getData]]];
        
        NSLog(@"decryped Secretkey is %@",message);
    }
    
   
    
    
}

- (IBAction)showPlaindata:(id)sender
{
     wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.sample.keychain" accessGroup:nil];
    
    NSString *_stringfromkeychain;
    NSData *_datafrmkeychain,*_archive;
    id obj;
    
    /********************************************
     *********Get Password from keychain*************
     ****************************************
     */
    _stringfromkeychain = [wrapper objectForKey:(__bridge id)(kSecValueData)];
    ;
    
    // NSLog(@"somestring is %@",_stringfromkeychain);
    _archive = [NSKeyedArchiver archivedDataWithRootObject:_stringfromkeychain];
    
    obj = [NSKeyedUnarchiver unarchiveObjectWithData:_archive];
    if ([obj isKindOfClass:[NSString class]])
    {
        NSLog(@"nsstring");
        
        //NSString *message = [AESCrypt decrypt:_stringfromkeychain password:SYMMETRICKEY];
        
        NSLog(@"Keychain pwd is %@",_stringfromkeychain);
    }
    else if ([obj isKindOfClass:[NSData class]])
    {
        NSLog(@"NsData");
        
        _datafrmkeychain = [wrapper objectForKey:(__bridge id)(kSecValueData)];
        
        NSString *message = [[NSString alloc] initWithData:_datafrmkeychain encoding:NSUTF8StringEncoding];
        
        NSLog(@"Keychain pwd is %@",message);
    }
    
    
    /********************************************
     *********Get Username from keychain*************
     ****************************************
     */
    _stringfromkeychain = [wrapper objectForKey:(__bridge id)(kSecAttrAccount)];
    ;
    
    //NSLog(@"somestring is %@",_stringfromkeychain);
    _archive = [NSKeyedArchiver archivedDataWithRootObject:_stringfromkeychain];
    
    obj = [NSKeyedUnarchiver unarchiveObjectWithData:_archive];
    if ([obj isKindOfClass:[NSString class]])
    {
        NSLog(@"nsstring");
        
        //NSString *message = [AESCrypt decrypt:_stringfromkeychain password:SYMMETRICKEY];
        
        NSLog(@"Keychain Username is %@",_stringfromkeychain);
    }
    else if ([obj isKindOfClass:[NSData class]])
    {
        NSLog(@"NsData");
        
        _datafrmkeychain = [wrapper objectForKey:(__bridge id)(kSecAttrAccount)];
        
        NSString *message = [[NSString alloc] initWithData:_datafrmkeychain encoding:NSUTF8StringEncoding];
        
        NSLog(@"Keychain Username is %@",message);
    }
    
    /********************************************
     *********Get SecretKey from keychain*************
     ****************************************
     */
    _stringfromkeychain = [wrapper objectForKey:(__bridge id)(kSecAttrService)];
    ;
    
    //NSLog(@"somestring is %@",_stringfromkeychain);
    _archive = [NSKeyedArchiver archivedDataWithRootObject:_stringfromkeychain];
    
    obj = [NSKeyedUnarchiver unarchiveObjectWithData:_archive];
    if ([obj isKindOfClass:[NSString class]])
    {
        NSLog(@"nsstring");
        
       // NSString *message = [AESCrypt decrypt:_stringfromkeychain password:SYMMETRICKEY];
        
        NSLog(@"Keychain Secretkey is %@",_stringfromkeychain);
    }
    else if ([obj isKindOfClass:[NSData class]])
    {
        NSLog(@"NsData");
        
        _datafrmkeychain = [wrapper objectForKey:(__bridge id)(kSecAttrService)];
        
        NSString *message = [[NSString alloc] initWithData:_datafrmkeychain encoding:NSUTF8StringEncoding];
        
        NSLog(@"Keychain Secretkey is %@",message);
    }
	
}

- (IBAction)deleteFromKeychain:(id)sender
{
    //BBBBBB
//    [wrapper resetKeychainItem];
//    wrapper = nil;
    
    NSString *encryptedtext;
    
   // NSString *key = @"a16byteslongkey!a16byteslongkey!";
    
    // NSString *key = @"a16byteslongkey!";

    
//    NSData *plaintext =  [[@"PA-37" dataUsingEncoding:NSASCIIStringEncoding] AES256EncryptWithKey: key];
//    
//  encryptedtext =  [[NSString alloc] initWithData:plaintext encoding:NSUTF8StringEncoding];
    
//    _datafrmkeychain = [wrapper objectForKey:(__bridge id)(kSecAttrService)];
//    
//    NSString *message = [[NSString alloc] initWithData:_datafrmkeychain encoding:NSUTF8StringEncoding];
    
//    NSString *key = @"a16byteslongkey!a16byteslongkey!";
//    NSString *plaintext = @"iphone";
//    
//    NSString *ciphertext = [plaintext AES256EncryptWithKey: key];
//    NSLog(@"ciphertext: %@", ciphertext);
//    
//    plaintext = [ciphertext AES256DecryptWithKey: key];
//    NSLog(@"plaintext: %@", plaintext);
    
    NSLog(@"encrypted: %@", encryptedtext);
    
//    NSData *data = [@"PA-37" dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *error;
//    NSData *encryptedData = [RNEncryptor encryptData:data
//                                        withSettings:kRNCryptorAES256Settings
//                                            password:key
//                                               error:&error];
//
//     encryptedtext =  [[NSString alloc] initWithData:encryptedData encoding:NSUTF8StringEncoding];
//    NSLog(@"encrypted: %@", encryptedtext);
    
    NSString *key = @"a$sYm#k*kaA@e%Bw";
    NSString *plaintext = @"PA-69";
    
    NSString *ciphertext = [plaintext AES128EncryptWithKey: [NSString stringWithFormat:@"%s", [singleton getData]]];
    NSLog(@"ciphertext: %@", ciphertext);
    
//    plaintext = [ciphertext AES256DecryptWithKey: key];
//    NSLog(@"plaintext: %@", plaintext);
}


#pragma Helper Methods

@end
