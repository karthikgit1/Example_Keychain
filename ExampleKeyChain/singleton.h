//
//  singleton.h
//  ExampleKeyChain
//
//  Created by Vy Systems - iOS1 on 9/15/14.
//  Copyright (c) 2014 Vy Systems - iOS1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface singleton : NSObject
@property (nonatomic,strong) NSString *User_FirstName_sing;
@property (nonatomic,strong) NSString *User_LastName_sing;
@property (nonatomic,strong) NSString *User_Email_sing;
@property (nonatomic,strong) NSString *User_Contect_sing;
@property (nonatomic,strong) NSString *User_DOB_sing;

@property (nonatomic,strong) NSString *Submit_ID;

@property(nonatomic,strong)UIImage *img1;

@property(nonatomic,strong)NSString *SelctedAlbumName_sing;



+(id)singletonFunction;
+(char *)getData;
@end
