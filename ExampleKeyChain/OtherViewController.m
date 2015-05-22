//
//  OtherViewController.m
//  ExampleKeyChain
//
//  Created by Vy Systems - iOS1 on 3/6/15.
//  Copyright (c) 2015 Vy Systems - iOS1. All rights reserved.
//

#import "OtherViewController.h"
#include <stdlib.h>

#import "singleton.h"
#import "AESCrypt.h"

@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)showKeychain:(id)sender
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
    

}


@end
