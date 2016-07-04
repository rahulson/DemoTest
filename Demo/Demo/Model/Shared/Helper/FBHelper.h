//
//  FBHelper.h
//
//  Created by Rahul Soni on 07/10/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#define Alert(title,msg)  [[[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
@interface FBHelper : NSObject
@property(nonatomic,strong)FBSDKLoginManager *manager;
typedef void(^FacebookCallback)(BOOL success, id result);

+ (void)loginWithFaceBook:(FacebookCallback)callBack;
+(void)logout;
@end
