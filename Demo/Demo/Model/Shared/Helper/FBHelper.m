//
//  FBHelper.m
//  
//
//  Created by Rahul Soni on 07/10/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import "FBHelper.h"
static FBHelper *singleton = nil;
@implementation FBHelper

+(FBHelper *)sharedInstance{
    @synchronized (self){
        
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            singleton = [[FBHelper alloc] init];
            singleton.manager = [[FBSDKLoginManager alloc]init];
        });
    }
    
    return singleton;
    
}

+(void)loginWithFaceBook:(FacebookCallback)callBack{
    [[FBHelper sharedInstance]loginCallBack:callBack];
}

- (void)loginCallBack:(FacebookCallback)callBack
{
    _manager = [[FBSDKLoginManager alloc] init];
    [_manager logInWithReadPermissions:@[@"public_profile",@"email",@"user_birthday"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
        } else if (result.isCancelled) {
            // Handle cancellations
        } else {
            if ([FBSDKAccessToken currentAccessToken])
            {
                //https://graph.facebook.com/\(id)/picture?type=large
               FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{@"fields" : @"id,name,email,picture,birthday"                                                                                                            }];
                [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    if (result)
                    {
                        NSMutableDictionary *userInfo = nil;
                        if( [result isKindOfClass:[NSDictionary class]] ){
                            userInfo = (NSMutableDictionary *)result;
                        }
                        NSLog(@"Fetched Result %@",result);
                        if(callBack){
                            callBack(!error, userInfo);
                        }
                    }
                    else
                    {
                        
                    }
                    
                }];
            }
            
        }
    }];
    
    
}
-(void)LogoutWithFaceBook{
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [_manager logOut];
}
+(void)logout{
    [[FBHelper sharedInstance]LogoutWithFaceBook];
}
@end
