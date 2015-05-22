//
//  ViewController.h
//  ExampleKeyChain
//
//  Created by Vy Systems - iOS1 on 9/4/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeychainItemWrapper.h"
#import "NSData+AES256.h"
@interface ViewController : UIViewController
{
    KeychainItemWrapper *wrapper;
    
    //KeychainItemWrapper *passwordItem;
    //KeychainItemWrapper *accountNumberItem;
    
   IBOutlet UIToolbar *toolbar;
}
@property (weak, nonatomic) IBOutlet UIButton *btnsave;
@property (weak, nonatomic) IBOutlet UIButton *btnshowencrpted;
@property (weak, nonatomic) IBOutlet UIButton *btnshowdecrypted;
@property (weak, nonatomic) IBOutlet UIButton *btndelete;



//@property (nonatomic, retain) KeychainItemWrapper *passwordItem;
//@property (nonatomic, retain) KeychainItemWrapper *usernameItem;

- (IBAction)saveUserDetails:(id)sender;
- (IBAction)showEncrypteddata:(id)sender;
- (IBAction)showPlaindata:(id)sender;
- (IBAction)deleteFromKeychain:(id)sender;

@end
