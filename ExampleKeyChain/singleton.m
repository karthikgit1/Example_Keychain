//
//  singleton.m
//  ExampleKeyChain
//
//  Created by Vy Systems - iOS1 on 9/15/14.
//  Copyright (c) 2014 Vy Systems - iOS1. All rights reserved.
//

#import "singleton.h"
#include <stdlib.h>

#import "AESCrypt.h"

@implementation singleton
+(id)singletonFunction
{
    static singleton *singletonObject = nil;
    
    if (singletonObject == nil)
    {
        singletonObject = [[singleton alloc]init];
    }
    
    return singletonObject;
}


+(char *)getData
{
    char* p12;
    p12 = (char*)malloc(sizeof(char)*16);
    
   // strcpy(p12,"Sy#m$1cK%@");
    
    free(p12);
    
    return strcpy(p12,"a$sYm#k*kaA@e%Bw");
}

@end
