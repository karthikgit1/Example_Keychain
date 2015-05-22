//
//  main.m
//  ExampleKeyChain
//
//  Created by Vy Systems - iOS1 on 9/4/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/sysctl.h>
#include <stdlib.h>
//#include <sys/ptrace.h>

#include "Crackify.h"

static int is_debugger_present(void)
{
    int name[4];
    struct kinfo_proc info;
    size_t info_size = sizeof(info);
    
    info.kp_proc.p_flag = 0;
    
    name[0] = CTL_KERN;
    name[1] = KERN_PROC;
    name[2] = KERN_PROC_PID;
    name[3] = getpid();
    
    if (sysctl(name, 4, &info, &info_size, NULL, 0) == -1) {
        perror("sysctl");
        exit(-1);
    }
    return ((info.kp_proc.p_flag & P_TRACED) != 0);
}

int main(int argc, char * argv[])
{
    /*
    if (is_debugger_present())
    {
        printf("Debugger detected! Terminating...\n");
        exit(-1);
    }
   */
 /*
#ifndef DEBUG
    ptrace(PT_DENY_ATTACH, 0, 0, 0);
#endif
    
    if ([Crackify isJailbroken])
    {
        exit(-1);
    }
    
    if ([Crackify isCracked])
    {
        exit(-1);
    }
    */
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}


