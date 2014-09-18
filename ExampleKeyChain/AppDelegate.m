//
//  AppDelegate.m
//  ExampleKeyChain
//
//  Created by Vy Systems - iOS1 on 9/4/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"


#import "KeychainItemWrapper.h"
#import "singleton.h"
#import "AESCrypt.h"

@implementation AppDelegate
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

KeychainItemWrapper *wrapper;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self getData];
   
    return YES;
}

-(void)getData
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
    
}



							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [UIPasteboard generalPasteboard].items = nil;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    //Validate input from the url
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



@end
